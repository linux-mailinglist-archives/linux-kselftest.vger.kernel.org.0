Return-Path: <linux-kselftest+bounces-27376-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C00F9A42CB1
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 20:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF4CC174EF1
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 19:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F51E1FE465;
	Mon, 24 Feb 2025 19:25:50 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414891FDA79;
	Mon, 24 Feb 2025 19:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740425150; cv=none; b=YlLGNDFaK47aqX+U4l0SgceOMBFf1bsXJjpXxHjPdNgeIzcF2f98FZZWeftoKJ8lga9sXhLwIK5ASMq85dFRCfWtgO71rLS8LCSGTlWO5n+Jd3qRXFXN9G+o75FfK3zQZXGD2BduHFztkf7rPlHuR+aNix3lLTwAzISDcK+pH0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740425150; c=relaxed/simple;
	bh=c2VCGnqGlHyIiaBG7afB7IsmtMLjL40OpGxvl+/WTpg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h8H2KXCzkkgjZOi27+dDPMstAuv6Laees5UA4JSC9/sM3QFbybD3y3Ad24m5krt5O/otXhfTlzRlVYcCJQOMgr0xXQFGBQDim1x73uql+a7g91VHQSqMqPc9T6WMsU5IavkIO2I5kjcz1GjtpydX6z7LB07bHS9m0fayLHlPDGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50DDC4CED6;
	Mon, 24 Feb 2025 19:25:48 +0000 (UTC)
Date: Mon, 24 Feb 2025 14:26:24 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Beau Belgrave <beaub@linux.microsoft.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, realxxyq@163.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yiqian Xun <xunyiqian@kylinos.cn>
Subject: Re: [PATCH v1] selftests/user_events: Fix failures caused by test
 code
Message-ID: <20250224142624.47733377@gandalf.local.home>
In-Reply-To: <20250224192105.GA48-beaub@linux.microsoft.com>
References: <20250221033555.326716-1-realxxyq@163.com>
	<b62b6dbf-eeb1-495d-a86b-38f05a17d60e@linuxfoundation.org>
	<20250221122842.379198f9@gandalf.local.home>
	<20250224192105.GA48-beaub@linux.microsoft.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Feb 2025 19:21:26 +0000
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> > Beau?
> >   
> 
> I applied it locally and ensured it passed (seems timing related).
> 
> Acked-by: Beau Belgrave <beaub@linux.microsoft.com>

Thanks Beau,

Shuah,

Please apply this patch:

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

