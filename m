Return-Path: <linux-kselftest+bounces-27811-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA75A48B50
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 23:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0769188E20E
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 22:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F351527291A;
	Thu, 27 Feb 2025 22:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTSTOnwa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A8E272903;
	Thu, 27 Feb 2025 22:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740694891; cv=none; b=eW2s7iw6CM3YS3JynA8ZfrtmLqdULsnB0MUbMQYe42EAAIfK5rrAvY33n813ps3KDILBs8IZ/FIilC/QFKW5OlrFbzfxnMQ+EwMWlseL5h/qxKj2h3aQjpzhCcOdymOnDDZxi+/qr5w2Bw7Celf95Ge8zxBE3OOG1brwpgyaKGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740694891; c=relaxed/simple;
	bh=Mh/4iXLUB3Pnxg08CIwmzUUPg4yTpsUSyIqdEojyAaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XgXqe+DG8pJZ/LmG4oNOO/Ojc7Tjdk8YegB/JLP9J86vEvM3ZfzAwFDohrOuV7kfIqoFsiwGtHLozGdfhVOF03cVjawzH4UcCcIdRc3YuWW/k0ESnUXWuqYe0X6VPM5tFy4J6Hv687YR49+5MRfzFFwFysC9JqpYajvo9X/1ZNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTSTOnwa; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22328dca22fso24139725ad.1;
        Thu, 27 Feb 2025 14:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740694890; x=1741299690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gjcFu4QJ69OtpdwIdEkRfaI1N2rsWL887lgwcRC5wmM=;
        b=NTSTOnwaBrXrD3xZKmX0knENsx0ehpO5f9d8RNLD+VWNXizYrstHV2+cz0bnXzmzRy
         qvadU3h35UPACtyPWkM0ivbC4OfOiiQbNcU3pCwJXFLfOkP4/lQ0EGrvM8abqK1mOtR/
         W6o3WV3b0KGr18IzeIPuzQQabHPKjHemkwxYKDUheSUapsiqLGbUZb8aOTKoXnca15Nv
         gDqfJDG/VAwBWQOpIfuvgyaXPOg/YrYmbjllCPaiSJPsmLdgcAA1T8UvLMuf64ZWqYnQ
         T7bKcHz5iFTBRJKVUFKZpeUqODNE+Yetyc0NVwCkyXsy5Gwh8UKY5A/N53AwEb/dOFPN
         EtJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740694890; x=1741299690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gjcFu4QJ69OtpdwIdEkRfaI1N2rsWL887lgwcRC5wmM=;
        b=q9TUbySl/HCmHQoPAeek6rtChyzZ2nBP9xlD556sBB/UlGv9XfLEb8r+PeE2FyKymG
         SC+zMfB1DvBIMW9yfaX6lQ9PFbwjEnjtoiBWeeLO3eFE27Kvl3WIWn7Ec3d77H0MLmDr
         a5hRy0TLkXLadFH8zdbtJL3tNJ7EbQtebJdyWqrW4+WnwvO/klmsfpHTuBGejbnbU/YH
         PSgrKATl3upM0Y1DzNKeLresgeIPqLEeczR1AaxkguroCit4PAs8m/b0XD8ScrCX8qEo
         hXsWrKA85pyWPsphioZ2URvI9WbWvV3yuAvfpR62StW3C9vOmrAf+02j1O/8kArD6D4K
         7UFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGxzpd+ViZKd5gbCZIg2zLITHIcZQyfbSro5Z69Y1bmSHFbPO4PRELK2XdKRVdvCfPeXI=@vger.kernel.org, AJvYcCVYY9oLTfEay4hugd6Y3ncPtlHUlEasOuhUMnnxQzZtxMxNM9XL7pqUKMr83hfbBuLxQvzTxhjTvspJd1yH@vger.kernel.org, AJvYcCX/TME3BdChZKdOTJOqi/PgHZ7slDfeWbcgG4l0zvacGuwliePSCM9icOoh2TSt5AhjIuzRfMGDgJHeMc7igDnG@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9GV7eOChyWozk5eg/MbqLhGwA52F/FjNSkAI2H5HdTQPNQ/Hw
	y1eVB+LB2YpM2Y132HvpYotpXOvEF6RF32U5eXzS0FKfT46M6e8=
X-Gm-Gg: ASbGncs2WVPr7LFJvNPC9/3Nftlb8al85v9amU33BSyTG6QEwNIzfCyQM/tYeVML0Dh
	peC0wDMkT+FljBYMP4WYZf2V03PBEnjLifzms/LdkGlHAswXjlu5KVpunJAmDhNeDdx9yvZnLj7
	LDigeUXUSW+r70pHM2uKN9L92AF5mcZYVXrRuGz8jgVn2/kh7dESMJ8uV6PCVbyElL104SADBAa
	7wuHsdzMhBjvQD/fbiaZIEzp0ORTvy1kaDwYnXBFgLMYxexgjtOxXhqiwW8bwywKVpP0g7ia1HD
	1awR4vBfcQB0wjiw7hS52ODnGA==
X-Google-Smtp-Source: AGHT+IFF0RPFfhexEjkENhbnL8UXdlvXeM575JiT765G6UKPAigJXPviJvci1kdBs/beEuh9+MVcow==
X-Received: by 2002:a05:6a00:b8b:b0:730:794e:7aca with SMTP id d2e1a72fcca58-734ac3f4ce4mr1548090b3a.16.1740694889829;
        Thu, 27 Feb 2025 14:21:29 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-734a005f9a1sm2310439b3a.175.2025.02.27.14.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 14:21:29 -0800 (PST)
Date: Thu, 27 Feb 2025 14:21:28 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Alexis Lothore <alexis.lothore@bootlin.com>, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 07/10] selftests/bpf: test_tunnel: Move geneve
 tunnel test to test_progs
Message-ID: <Z8DlaB3u2HLWZKdu@mini-arch>
References: <20250227-tunnels-v1-0-33df5c30aa04@bootlin.com>
 <20250227-tunnels-v1-7-33df5c30aa04@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250227-tunnels-v1-7-33df5c30aa04@bootlin.com>

On 02/27, Bastien Curutchet (eBPF Foundation) wrote:
> geneve tunnels are tested in the test_tunnel.sh but not in the test_progs
> framework.
> 
> Add a new test in test_progs to test geneve tunnels. It uses the same
> network topology and the same BPF programs than the script.
> Remove test_geneve() from the script.
> 
> Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

