Return-Path: <linux-kselftest+bounces-22209-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B08D9D1A83
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 22:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD7FA1F229BF
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 21:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01421E5722;
	Mon, 18 Nov 2024 21:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WyICigaq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A06155C94;
	Mon, 18 Nov 2024 21:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731965006; cv=none; b=qdAsiauZIHvkSiHyP2p4OfEa/UVP1Xf/9vCm2dsmXdDDamKy/PEFlkJrn3JW4YC9Oduwpiqnf9oQA5z6Y04SkVdYDXYReqVxE4U7zgLh9S2lFWTATy5b1kyzFzg1UCtOaE9+9scm/tb4wMWVreJWb3y0XeTJsDb/dn8Skx3nq6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731965006; c=relaxed/simple;
	bh=jqiM9xMmvt4BUKSPqx4li3rFh9ip4ahCeoRzbo0AJk4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ac1QHWGAStNnNnkYuJr6JJDcWaHMFb4HF3Blq3NFIJ2MsvVNMrIyV3hG68dRSiTk3XLrgUh7ZwC6RK5VTt/DUtBPqvNN27BmoSKyxfpjcq9rr3TI8uK5X29IomkanvTZPdAPponBEFXzS96EG7iPdGTozXkDkNARZopdtVFFmqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WyICigaq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D989BC4CED6;
	Mon, 18 Nov 2024 21:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731965006;
	bh=jqiM9xMmvt4BUKSPqx4li3rFh9ip4ahCeoRzbo0AJk4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WyICigaqzrwm5Fq9Z5CtOV9O5lD2I/7WBbJ4vBnehYLIHF1s2Wb4Q63ZqcHeabkOJ
	 ffW3DfoYq4bAuT5fc1/fmzSf0Itxgm+tt9N9eo/e57bwDus020r2w52SLLbbYXsFsn
	 0Uq1jgEF2PzRUuHFTRGmD6J74mOv88mo2Dhk/z9pmbjClyUpYOddvuD+ZSnKhOAUKx
	 8OrFsZ3neSnVvppzko7GPA7zl8+2rZAfRgnyndTdx4ccxsi9zDHV5Vp2wwZbTCQByF
	 jond1lueO5eIDhPGK/Rya+oDdmnSJ2mRg8JzLd+NtSJrGoMvip0fdbjWSfbraM5CNr
	 se88gHghvHAjQ==
Date: Mon, 18 Nov 2024 13:23:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: shuah@kernel.org, Tim.Bird@sony.com, linux-kselftest@vger.kernel.org,
 workflows@vger.kernel.org
Subject: Re: [RFC v2] MAINTAINERS: split kselftest entry into 'framework'
 and 'all'
Message-ID: <20241118132324.3248c97d@kernel.org>
In-Reply-To: <8192e307-b2b9-4c48-87e2-31073c084218@linuxfoundation.org>
References: <20241115200912.1009680-1-kuba@kernel.org>
	<8192e307-b2b9-4c48-87e2-31073c084218@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Nov 2024 14:02:29 -0700 Shuah Khan wrote:
> > Sorry for the delay, the responses to v1 weren't super positive
> > but I keep thinking this would be very useful :) Or at the very
> > least I find workflows@ very useful and informative as a maintainer.
> > 
> > Posting as an RFC because we need to create the new ML.  
> I have to repeat the same thing I said when you sent RFC v1
> It is going to add the confusion - people don't cc the one
> mailing list we have now.
> 
> I am going to have to say no. Sorry.

To me the dissonance between your admission that people don't CC the
current list (IOW status quo isn't great) and the resistance to change
is fairly apparent. But it is obviously your call.

