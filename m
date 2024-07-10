Return-Path: <linux-kselftest+bounces-13465-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED58392D281
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 15:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 910921F238AD
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 13:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4600192B60;
	Wed, 10 Jul 2024 13:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UAxFUac4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B1D192492;
	Wed, 10 Jul 2024 13:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720617075; cv=none; b=qoWsT6OFpwl59cnDNbRK+WDBQelUhrpEczKvL7S8ed15cnnjnfKkk71vuEBnjnBsBhXCT2IGCwn7V9m7SAlP4z+XPyZ2Yv6y8PGlojGHiGgJpbsF/V98RlXDSm+cSJbSZKnTN6cmA22473UOum5nLODxMzTN3DlZq6vtGTpXiJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720617075; c=relaxed/simple;
	bh=K1L5O4yDfeo+nHU6+Kb14HmTN/m8dxGNnRV2vDihEFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mW6QYkD4qSnfkPE/A6rwvNeV2PcwbeQ5aCd+AT6/cOXkOjEi7v6iowjPQdONH9ejKEQBv3rT9vuOdQqzohm6Q3Sbl1OofBLDI8WSwU82Mqw0XKe5pRpijJdOIC6U8VML3CTL7W1Eiq9lA2w/uhvbNY/KtDNGR88ARuMWMoBHy0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UAxFUac4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFDFAC32781;
	Wed, 10 Jul 2024 13:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720617075;
	bh=K1L5O4yDfeo+nHU6+Kb14HmTN/m8dxGNnRV2vDihEFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UAxFUac4mPW7XLXA3Pjfuyrm9FBbN9lTgOXU3WP4UV+KNhs/doopHqGB8k4nuMjsw
	 +UfpGDg1SmiwjGa6dOtoVVaE1CMqQVabn90InJeBZ1zEkzjQkGnJ1HLifqfpQW/OeL
	 bOO/R+JGkJwKcdu/SLsVPYaPdaGJTkwidmDlCQAo=
Date: Wed, 10 Jul 2024 15:11:12 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Cc: Shuah Khan <shuah@kernel.org>, kernel@collabora.com,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernelci@lists.linux.dev
Subject: Re: [PATCH v2 0/3] kselftest: Add test to report device log errors
Message-ID: <2024071003-islamist-expediter-a22c@gregkh>
References: <20240705-dev-err-log-selftest-v2-0-163b9cd7b3c1@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240705-dev-err-log-selftest-v2-0-163b9cd7b3c1@collabora.com>

On Fri, Jul 05, 2024 at 07:29:53PM -0400, Nícolas F. R. A. Prado wrote:
> Log errors are the most widely used mechanism for reporting issues in
> the kernel. When an error is logged using the device helpers, eg
> dev_err(), it gets metadata attached that identifies the subsystem and
> device where the message is coming from. This series makes use of that
> metadata in a new test to report which devices logged errors.
> 
> The first two patches move a test and a helper script to keep things
> organized before this new test is added in the third patch.
> 
> It is expected that there might be many false-positive error messages
> throughout the drivers code which will be reported by this test. By
> having this test in the first place and working through the results we
> can address those occurrences by adjusting the loglevel of the messages
> that turn out to not be real errors that require the user's attention.
> It will also motivate additional error messages to be introduced in the
> code to detect real errors where they turn out to be missing, since
> it will be possible to detect said issues automatically.
> 
> As an example, below you can see the test result for
> mt8192-asurada-spherion. The single standing issue has been investigated
> and will be addressed in an EC firmware update [1]:
> 
> TAP version 13
> 1..1
>  power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>  power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>  power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>  power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>  power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>  power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>  power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>  power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>  power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>  power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>  power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>  power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>  power_supply sbs-8-000b: driver failed to report `model_name' property: -6
>  power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>  power_supply sbs-8-000b: driver failed to report `energy_full_design' property: -6
>  power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>  power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>  power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>  power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>  power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> not ok 1 +power_supply:sbs-8-000b
>  Totals: pass:0 fail:1 xfail:0 xpass:0 skip:0 error:0
> 
> [1] https://lore.kernel.org/all/cf4d8131-4b63-4c7a-9f27-5a0847c656c4@notapiano
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

