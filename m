Return-Path: <linux-kselftest+bounces-24886-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B51E1A18099
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 15:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A67917A2884
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 14:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7691F3FF6;
	Tue, 21 Jan 2025 14:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBS1IcEP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2D81F3FDA;
	Tue, 21 Jan 2025 14:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737471424; cv=none; b=WIaa9DbTSY2vJvMlPNO4e6P/xHjBZCRGKk37r23x2glM124BI/5KspQCmWG0u5FS5yj01NJQtgLzS3uPJNvDLhJYsd9mmI8iF9B95KQaQGQpxOiGjCkQulySG/AqgyaUPpbNdzzZwQJSlnODQp3UswY0E6+Hve517kY1byryHlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737471424; c=relaxed/simple;
	bh=STREbbKIOKaVKCyyn6Bngx/JTH8nnsrWQHdqVhI3Vp4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=aMJCzwIbl/VqtIs4/ee4O4iP7YRYpgkD7JGI0hvlexEZcJNI9PLpHYek+PFu2VGX3ic7Qk6QuVc2DxrI2ajUcEQLc4acl7pdYZlAkQjbCyL5KYM0UFrgnriRM0eDd/09E3HFZP/roVeIWZdi7sYlS/0xOyHgh0JfJ4cRwCnx/9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBS1IcEP; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b6ef047e9bso526095085a.1;
        Tue, 21 Jan 2025 06:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737471421; x=1738076221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XhfzHaCu0hfOUT7G07sOpPFV31U0hz3p+JF3fI28lY=;
        b=cBS1IcEPsBD6GdLXtTkJ4+qK7EKLuU2vmsiYtHkGBVFO1oIK8ILwNvPKJS1S6kXk97
         Gwi9veTT7u42X+JxiswGgJafKsksEXdc4n9z6mnvzmVKwyC/t66Rls9otYJD3v6s7Gjt
         TjUXBrL2VovLxkIU2ydL182ZidwFbK/mFVza7Kx7KIerIcXR+QIKx/jpyTPe7k5Im7Eb
         JI6fUwwqhIxICn6fmTDIAW790YvTPdTWiKliBeTvY1k3Yxb0Vlgzb1/Stq3J2wzi/dG4
         eXK4+HJFTILJlYl0xxn+jOBagBUhWWNlfP4BQCyS6ieS3EC+gNdMf6SEfiys63BBVsLR
         IooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737471421; x=1738076221;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0XhfzHaCu0hfOUT7G07sOpPFV31U0hz3p+JF3fI28lY=;
        b=wwgV+75KpSHhUiQLuQq8sJRUFFR9Ijdsre6zWrytqr7nLFptnawQoqOgB2vid1VfJc
         J9zwmx/pEALLoFBPVhr4YWU9U5a2xvMR/RKrrHB6jkCbwvaiC3X1zavY1bMVZWUsuLGz
         wM7thnn3dCIvwmWBzihGTTkWSOg2/bPbTJyiOsPa/IOos3J/OkeolIB4pwQ6e89/p8/R
         X+MaEP240J551WoilzkyMezGaDLTs+KuO8YFBKmRKHgfCnf9osVWq+D22/Drx+NVR4Dt
         0zd9BO6Sq6dZRSZshr7n2VfoKNacUy2vD1O0RstQj4U2eeZvHfMKJ1YZ/dXUonHhGSKM
         aeAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSPRN3Jla+Qt6NohJFhXm6JW2MmYe70eyqW4zFEc/1Q1e6X8TZ3fVqvbkJmHcGH+JTEEHa0QYdCNNdFjk0IzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YydT/Lf36APu+wG+Btp3QuwXyY8xkpHD62GQeEMeHUFqaW1tS1m
	UEuAcxXtbfgw1ZZE3BMfyOuqO+a/RqXWGoHWjxFrjd3r+Va8FIu+
X-Gm-Gg: ASbGnctUzQxjOxTty4xx1Gf6nlX4tVnVgF6Uj5E1b6MWsSMbNdZib4xQnSZKYpLLLm5
	A6Qvwlq9A4GKNRqhhzA0x9mvtcYheMoI5RMKumzZMW7+cMoi40TUxGR1Ko+1/EMQPBM5sitpsp2
	Hoew1h9whKlhFPoZ2C4kCiGI/NFhLQGZ86PPD08+DK3417Oe26AR1gm0VNs0Ply2eerS2wfAPlD
	7xXyKHj4jnpGf0APy06I2ndXjjUCuEUBkxjIb5p4FgVGOaWYBus+6rXpAl3ZDwIF3NbUXvWpybF
	f9UXTMU1z9oU27ILdrFU3jIydkqQMJ7S9TvkTKoxyw==
X-Google-Smtp-Source: AGHT+IEuh2jbrvxdWmCO/ZqNTdDPzcNmTGMiRRECxQHx9gKm5/A68LN7T+G9Nnb42GR3io4O/bttOw==
X-Received: by 2002:a05:620a:43a2:b0:7b1:7508:9f38 with SMTP id af79cd13be357-7be523e2a07mr4026747485a.16.1737471421560;
        Tue, 21 Jan 2025 06:57:01 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be614d98b2sm566139985a.76.2025.01.21.06.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 06:57:01 -0800 (PST)
Date: Tue, 21 Jan 2025 09:57:00 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, 
 shuah@kernel.org, 
 willemb@google.com, 
 matttbe@kernel.org, 
 linux-kselftest@vger.kernel.org
Message-ID: <678fb5bc9c42e_241c392941@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250121143423.215261-1-kuba@kernel.org>
References: <20250121143423.215261-1-kuba@kernel.org>
Subject: Re: [PATCH net-next] selftests/net: packetdrill: more xfail changes
 (and a correction)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> Recent change to add more cases to XFAIL has a broken regex,
> the matching needs a real regex not a glob pattern.
> 
> While at it add the cases Willem pointed out during review.
> 
> Fixes: 3030e3d57ba8 ("selftests/net: packetdrill: make tcp buf limited timing tests benign")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

