Return-Path: <linux-kselftest+bounces-26731-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABF0A37305
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Feb 2025 10:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618EC188D8EB
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Feb 2025 09:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03A1175D5D;
	Sun, 16 Feb 2025 09:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hc48iGK+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8500149E13;
	Sun, 16 Feb 2025 09:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739697464; cv=none; b=Qp1zXDw07+U46rK858PHTZvcNhBX7GpZOe3x2RoDMcDHgVz/kS4QxYAUyPa8CNusJISj0ebNRztoyvb3uW7wMYskU7Cncbf6tU3xsCrbmsEK7ahr4ySUeCfyP1tV1vqrewxgQeLgFtKOw3qpJ+WR7HywPYfFMmun9BbgbpdXdkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739697464; c=relaxed/simple;
	bh=ek7gvcKIuIM9dze5JlvQI43Xi8NUMbJ6o4J2HIzbdoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EzsDvXGaeCfQmzS7ferLz/oT62WEtIPvk2GueuKKftStW7VB1Gu1lGqOFjw4//EaeGVS4/qULSDadCJIz8DY/vzMyQNd317W6DPxG53V3FHYPMSs+Yl6CLj7M9rXiVc+0nRv1s/UwzLBoAtSxJsU33kRaiRiwJ8MNWeBdWrnj/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hc48iGK+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFE1AC4CEE4;
	Sun, 16 Feb 2025 09:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739697464;
	bh=ek7gvcKIuIM9dze5JlvQI43Xi8NUMbJ6o4J2HIzbdoo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hc48iGK+59y17f99z2lfDAvuruEC5S3ZE3PgjkFHpJRJwNEi1Q8Ip1yp/4u6mDn0I
	 YTrniyjhwx5c9qqIN54xIQRtt2DnH1+6h4izYeWy4fS4Xa5smMQhIBCSGbqL9I7S93
	 qAMtHYCzZOqdNFvrWfUHr82XsckFANcdOBSncuetfl+qtXZboWAIlgkjAxZP4a/Kkn
	 Tr1Fs98lN+EbpmstHpJQ09PD+xRE7i0IKyrxsvMc2WXi2sbuadCsTYVdgAb98g96Ah
	 ScELy/oQv4OfPgiKGr1GULYyDckNv2NPCIPpYTQMawGam5kV2/0PUZfdIPTzxc2C6f
	 4p+Q3D/RQI/bQ==
Date: Sun, 16 Feb 2025 09:17:39 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Peter Seiderer <ps.report@gmx.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Artem Chernyshev <artem.chernyshev@red-soft.ru>,
	Nam Cao <namcao@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH net-next v5 8/8] net: pktgen: use defines for the various
 dec/hex number parsing digits lengths
Message-ID: <20250216091739.GW1615191@kernel.org>
References: <20250213110025.1436160-1-ps.report@gmx.net>
 <20250213110025.1436160-9-ps.report@gmx.net>
 <20250214201145.2f824428@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214201145.2f824428@kernel.org>

On Fri, Feb 14, 2025 at 08:11:45PM -0800, Jakub Kicinski wrote:
> On Thu, 13 Feb 2025 12:00:25 +0100 Peter Seiderer wrote:
> > Use defines for the various dec/hex number parsing digits lengths
> > (hex32_arg/num_arg calls).
> 
> I don't understand the value of this patch, TBH.
> 
> Example:
> 
> +#define HEX_2_DIGITS 2
> 
> -		len = hex32_arg(&user_buffer[i], 2, &tmp_value);
> +		len = hex32_arg(&user_buffer[i], HEX_2_DIGITS, &tmp_value);
> 
> The word hex is already there.
> There is still a two.
> I don't think the new define has any explanatory power?
> 
> Previous 7 patches look ready indeed.

Hi Jakub,

This one is on me. I felt the magic number 2 and so on
was unclear. But if you prefer the code as-is that is fine by me too.

