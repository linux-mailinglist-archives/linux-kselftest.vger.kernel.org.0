Return-Path: <linux-kselftest+bounces-15309-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE619951923
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 12:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60DF3B225E6
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 10:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD501AE030;
	Wed, 14 Aug 2024 10:41:13 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302D1137772;
	Wed, 14 Aug 2024 10:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723632073; cv=none; b=Oq3nLtxaaYaE3IMUtUt40eutEQjoSsB/Po+b7e48LNzTpK2FW9nEIIlpTBfA6LC3FwMWNT16m6zJI7ZWSzENpKeqMaGZdm9NQgQx7pV1SialE8j/SIx7Bftcxe+uLzsk3TbVdXBUCwdV1iLiakzLHQ3/rbIZlRXhrIHJohd7w34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723632073; c=relaxed/simple;
	bh=GrfhgTdwcOC7b0fHeuZAKfRJXDx7CObsVd9dSJmplzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3+6jC85JMsxEcx/l0nMth4KsAqVw3e+bmseYPwXhe7S2VezfTZWJAo7DuZiSKlMNLPk/UZlejK6a8Qw0QyU19C54MVSTgCSzZ9mozbn6gmajC1Cws66jwyIJC8JIHFUVwiduSbBtmW52aidJvD5xMEuf/maxVguQ4fbW4hyCto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309F1C4AF0D;
	Wed, 14 Aug 2024 10:41:08 +0000 (UTC)
Date: Wed, 14 Aug 2024 11:41:05 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Florian Weimer <fweimer@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>, jannh@google.com,
	linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
	Kees Cook <kees@kernel.org>, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFT v8 3/9] mm: Introduce ARCH_HAS_USER_SHADOW_STACK
Message-ID: <ZryJwQNsl3qCYMi_@arm.com>
References: <20240808-clone3-shadow-stack-v8-0-0acf37caf14c@kernel.org>
 <20240808-clone3-shadow-stack-v8-3-0acf37caf14c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808-clone3-shadow-stack-v8-3-0acf37caf14c@kernel.org>

On Thu, Aug 08, 2024 at 09:15:24AM +0100, Mark Brown wrote:
> Since multiple architectures have support for shadow stacks and we need to
> select support for this feature in several places in the generic code
> provide a generic config option that the architectures can select.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Deepak Gupta <debug@rivosinc.com>
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

