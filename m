Return-Path: <linux-kselftest+bounces-22229-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6D39D1EE1
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 04:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DF151F2230E
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 03:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343401482ED;
	Tue, 19 Nov 2024 03:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UU+Nk87j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADD9146A72;
	Tue, 19 Nov 2024 03:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731987444; cv=none; b=ee9qokTLxmGEzN78fJvEXm3qin1kqsv6H7qoRpz5m5/jhoH3/ikQUE6CtwGJfQ/TxF4O/tQ2wiwECe2YKWJObRrlvhb5sHigCvf4ADhOzSwy7oz9qBL7IqyoeDxBqMZk4KEOFxFM1EtC8rAklEH/LYu1m2GqoEzoNvLtg2OTdO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731987444; c=relaxed/simple;
	bh=dCaQDrjjsMlbKMHjkTKCfmDN0bnh7bTyWM1/3ifufWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=slkQuebX3RhBOjFx/mK0OYjBC6VhUjUle6URT95wDL7eM9LyCpl/tnq9pfxEFWHbpRhYskBOgWwkjGuXSUYzQm4UhtGdNZcvCX8qsqK6iV2MF+TQroF5WauTWhpSJOv4ihUkhYPlxDGxOi9+ogR9hydbx4o6UK/Z/mIJG8xgHtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UU+Nk87j; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20cdb889222so35854635ad.3;
        Mon, 18 Nov 2024 19:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731987442; x=1732592242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g2E2ZlpfPZCjUZubD0v6yvsYpnLBIbhUcb15gmeLAW8=;
        b=UU+Nk87jOIoDUWWoaNEmXQjkm6ihSk2UAStUxQs/SfPwUdkRtX0D/9aSj0fBFdTYx1
         SMm/6360hqsa6O59w51Fvxw4w3He2U7I0zOIpjKQATdcH7kuZ/ei2oYM4EVq92EvhEST
         A/1jh3DzR2PLYFW0rt5GVYIca6+i4kD0iw7DrZ4HdRHyq1HzhBKyoMHlUD8Pfvll8z0F
         l0G1J9TDAt+1+FhPLpZcYpsplGKTME1eU6XGuRH1jsrndcrr1cgpQ2kj7rBe1p8BV0CV
         4sZiMo8qYd59OL2DDZgc4kSA97pnjsONl05QjmqCJXH8317Yc8TKaGga/IGgDCGnXU2z
         IAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731987442; x=1732592242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2E2ZlpfPZCjUZubD0v6yvsYpnLBIbhUcb15gmeLAW8=;
        b=XZVqUuwQcAF2K2vH838/Wv8p2f/K5flOPrlkx0FI0Z2k44sfTDh2TE7GA7SnwlN+b7
         Xcs97z1jxWXVuyq3b20IO4llxJ8kiIw6rvqkyKbGlj5g1fPgRrrz+gpIlUmqoKq6q/Qf
         qSraN68Qg4zRa1GMHBp40jULQp4HQJbh0Fq+l9wsceY31r9OmJXIAOtkDSo8GaNYusD6
         AM14qzxZxuMZI3scxzYpxbTYqc7ZcEQn5MrxgXm2gLJwPxkBUqmbepupJ71Bk4W8PSoT
         W3sjsskndEEYOo6hLgS9MK0rukKekW/QXITQ/dXjs4UvyPxh+Xru3OG4wDkAOmUArnja
         7MCw==
X-Forwarded-Encrypted: i=1; AJvYcCUAeWFR/W9NX4jo6A3DP3NHX6XKNHjJpLAv8Em7zDs99PlO9xG51gkisPNMMJpB/B5a2wZMJOCyh1T6/e0Fp8jf@vger.kernel.org, AJvYcCVbVw1tQtbIEasAl+ZKLDXvHbKysalriK9TIGnq58sQTEht4FAUEOujTMl//yC16ODekObWSfCSRGp4ji8S@vger.kernel.org, AJvYcCW2y8jYGWpnHGlRp6vpt4ewAI0FGmJOV/Y7keaqwa4Z8eODzmGcMzsv3Qr84GSaqwjoZ08=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR99GlFpORg+0qw1zayvcw9zwDuaeVo863olQJBnXhhNR5uzPA
	UJ5PeGSi6ZRM0pkXK3oDR+ZmtVV5SD6U5xjL3/PlzhrrwD9evUDr
X-Google-Smtp-Source: AGHT+IFjjMSAg8vXQGT6xt9qDee1RQiBoViFJfIqzIwsQD9MT3RmvB4st8SRTNmASPhdxDFOmy7QyA==
X-Received: by 2002:a17:903:110c:b0:20b:9379:f1f7 with SMTP id d9443c01a7336-211d0ecb0a4mr221143125ad.40.1731987441660;
        Mon, 18 Nov 2024 19:37:21 -0800 (PST)
Received: from localhost ([2601:647:6881:9060:fd49:bc41:343a:fee5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea06ef69edsm9280679a91.1.2024.11.18.19.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 19:37:21 -0800 (PST)
Date: Mon, 18 Nov 2024 19:37:19 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: guanjing <guanjing@cmss.chinamobile.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, shuah@kernel.org, dxu@dxuuu.xyz,
	antony.antony@secunet.com, cupertino.miranda@oracle.com,
	asavkov@redhat.com, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] selftests/bpf: fix application of sizeof to pointer
Message-ID: <ZzwH77QE/Ch9+evD@pop-os.localdomain>
References: <20241117031838.161576-1-guanjing@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241117031838.161576-1-guanjing@cmss.chinamobile.com>

On Sun, Nov 17, 2024 at 11:18:38AM +0800, guanjing wrote:
> sizeof when applied to a pointer typed expression gives the size of
> the pointer.
> 
> tools/testing/selftests/bpf/progs/test_tunnel_kern.c:678:41-47: ERROR: application of sizeof to pointer
> 
> The proper fix in this particular case is to code sizeof(*gopt)
> instead of sizeof(gopt).
> 
> This issue was detected with the help of Coccinelle.
> 
> Fixes: 5ddafcc377f9 ("selftests/bpf: Fix a few tests for GCC related warnings.")
> Signed-off-by: guanjing <guanjing@cmss.chinamobile.com>
> ---
>  tools/testing/selftests/bpf/progs/test_tunnel_kern.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> index 32127f1cd687..3a437cdc5c15 100644
> --- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> +++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> @@ -675,7 +675,7 @@ int ip6geneve_set_tunnel(struct __sk_buff *skb)
>  	gopt->length = 2; /* 4-byte multiple */
>  	*(int *) &gopt->opt_data = bpf_htonl(0xfeedbeef);
>  
> -	ret = bpf_skb_set_tunnel_opt(skb, gopt, sizeof(gopt));
> +	ret = bpf_skb_set_tunnel_opt(skb, gopt, sizeof(*gopt));

Good catch!

I think sizeof(local_gopt) is better, to align with geneve_set_tunnel(),
what do you think?

Thanks.

