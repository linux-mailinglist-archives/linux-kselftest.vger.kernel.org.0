Return-Path: <linux-kselftest+bounces-20392-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F589AA246
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 14:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5262C2812FD
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 12:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD86319D88F;
	Tue, 22 Oct 2024 12:39:10 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94AD19D070
	for <linux-kselftest@vger.kernel.org>; Tue, 22 Oct 2024 12:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729600750; cv=none; b=oMOfFmOhkWHybQWdbw7P9DM+Hemr3uyoCmmTJ6spYRLc8kNI7VfIF4q9FDMlWeZfnzkbtmuO4ZXptZ1r/9LdMvU4qU+JL3HcAGBn38YEseyVYmIC7feOvgrxMcZfZZ5JMBVVZcmJkZuElylxJXy5l7UXNwvp80gSLO0dk6Y/G/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729600750; c=relaxed/simple;
	bh=6oHK4mzmRtW/vLJdU9W6SZ++qUpQ+QVW3OGFk++dzNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4wCrN7/Pr+2NWQzTOIwnHUjnvufxJkLWY8sj3PLtdqMxO8faLuFXcqh7+n3ALsgSgSAU0GUpc6sT4rwffD06m707iwPG94Dk2+NNW2AcBG3IViSt3cGnXXXK3p4abLtwuS20pWvSTs08xfoTryqKA5m/zhCXX2Ou5tOHroXm/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2C0FDA7;
	Tue, 22 Oct 2024 05:39:37 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE2633F71E;
	Tue, 22 Oct 2024 05:39:05 -0700 (PDT)
Date: Tue, 22 Oct 2024 13:38:58 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
	anshuman.khandual@arm.com, aruna.ramakrishna@oracle.com,
	broonie@kernel.org, catalin.marinas@arm.com,
	dave.hansen@linux.intel.com, jeffxu@chromium.org,
	joey.gouly@arm.com, shuah@kernel.org, will@kernel.org,
	linux-kselftest@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 3/5] arm64: signal: Improve POR_EL0 handling to avoid
 uaccess failures
Message-ID: <Zxec4oHMYXOSuqc3@e133380.arm.com>
References: <20241017133909.3837547-1-kevin.brodsky@arm.com>
 <20241017133909.3837547-4-kevin.brodsky@arm.com>
 <ZxEzAzmlIG66ZPVn@e133380.arm.com>
 <cf75979b-b94f-46cf-a8d0-37e5843a0d29@arm.com>
 <ZxZaaOEIVpSEv7C/@e133380.arm.com>
 <12041781-6be0-4492-b352-a8d153de3415@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12041781-6be0-4492-b352-a8d153de3415@arm.com>

Hi,

On Tue, Oct 22, 2024 at 02:34:09PM +0200, Kevin Brodsky wrote:
> On 21/10/2024 15:43, Dave Martin wrote:
> > On Mon, Oct 21, 2024 at 12:06:07PM +0200, Kevin Brodsky wrote:
> >> On 17/10/2024 17:53, Dave Martin wrote:
> >>> [...]
> >>>> +/*
> >>>> + * Save the unpriv access state into ua_state and reset it to disable any
> >>>> + * restrictions.
> >>>> + */
> >>>> +static void save_reset_unpriv_access_state(struct unpriv_access_state *ua_state)
> >>> Would _user_ be more consistent naming than _unpriv_ ?
> >> I did ponder on the naming. I considered user_access/uaccess instead of
> >> unpriv_access, but my concern is that it might imply that only uaccess
> >> is concerned, while in reality loads/stores that userspace itself
> >> executes are impacted too. I thought using the "unpriv" terminology from
> >> the Arm ARM (used for stage 1 permissions) might avoid such
> >> misunderstanding. I'm interested to hear opinions on this, maybe
> >> accuracy sacrifices readability.
> > "user_access" seemed natural to me: it parses equally as "[user
> > access]" (i.e., uaccess) and "[user] access" (i.e., access by, to, or
> > on behalf of user(space)).
> >
> > Introducing an architectural term when there is already a generic OS
> > and Linux kernel term that means the right thing seemed not to improve
> > readability, but I guess it's a matter of opinion.
> 
> Both good points. "user_access" seems to strike the right balance, plus
> it's slightly shorter. Will switch to that naming in v2.

Suits me (wasn't sure I was going to win that one actually!)

Cheers
---Dave

