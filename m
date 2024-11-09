Return-Path: <linux-kselftest+bounces-21730-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8209C2F3A
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Nov 2024 19:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAF92280F05
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Nov 2024 18:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4368819EEC0;
	Sat,  9 Nov 2024 18:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHCfx0LP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A5619ADB0;
	Sat,  9 Nov 2024 18:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731178474; cv=none; b=oNiMjMcyvFgOsYCcEJ39ajtVTkBDJ1qhOAyUedi4uQwgJKxuiTuwh9MYwCHh10Y49uN3eRZC1xvpJw+ioZb08krRUG9OVkvGbr4oz04xsKlXSyjEFypeDsyJWZMhvHDiWPcvPhquFIPbGNP876ng0Vte33n61e0T+OBgkx+X/SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731178474; c=relaxed/simple;
	bh=YH7ClifcMoUz4Md9QFyZKQn6Y5kckcViCFDHlX9qvUM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=TWbcXG98QQiewxXg+r3mknFsKYiPEsZGJK2Wfa+vXRv0kPGxvVpvjwVO53YBWJKP9Volt2EBOOAFBew9/RiB8TfUj6tSFvwMpMqbAo4mYU+wtLVTyUStAg7oX7fgTLhxBjuXvsvuTqM0lN5h5kQaRTpDDBKj6PLNAmtOtowNZmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHCfx0LP; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9a628b68a7so568789166b.2;
        Sat, 09 Nov 2024 10:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731178470; x=1731783270; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ggW0cG1LTIqavxbE80YU/eqIO8unC+7CGF0sLuNCCE=;
        b=bHCfx0LPiT/lVznWPg3ke08desN0C9BifQW3t3+kCpGPHJd2tvHkXgwXvTBAj3Nw9R
         8oavnU7jvia6nPKqeS3rqbSdy6Ix+4A11A4XIvdxF2QA5ydJ0yc7rVbcRjj7959txJ45
         bwEC0Oxn14+ZwuppacZc3sS/2r+G09+MYR4D2uue1zBwxUwhI/GSHTjfhmkvRbO55mHL
         HnDDiv/EKqOqGBJ6yz11Blsm/Bi+lzxn0+PidBLCemPcFzHObo6Kx9BO4HFCeh7VMO6U
         vdKj0rqx7gofDW53mH0odzBtm5m5jnjYMa/s9erSxcUEANgA+WPRDVdykrgUeXAp1EFP
         Flqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731178470; x=1731783270;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7ggW0cG1LTIqavxbE80YU/eqIO8unC+7CGF0sLuNCCE=;
        b=aO1VvIza7Bn+ER9DsXygl1W+dfydyINeBVjBR9pddLrcfidljb+GIdj5SXwln+SSvB
         v7WR0yXLKzuxVQ/u6PZ05aUu3q/azeBUCN4+dJ9tk8fAyjhC4j6ZhDgtZgJWYJ3LY5Nc
         IVQeX5nGyYmom7rjNnlc7KA7cAb0VzByjzoXUNSvWJEBVDpjXp8r36XRQMvDKMZXCom5
         p90Uw9iXoizn39tBHJ1NKasQylRIw+IlmGvECtsCcC/hsDep79oYkVI9RtD26ZXDmZZP
         +NSRO0xWpEaMSwkVu3xr0bwnujYGxq++GDDfyLEqly/jR7WR9MeDhaL2shOhRmaYDfe9
         Ru3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU4I1MwmswglOcTrCkeQnh98AklqQZbin2ixLP0Btoq/EKNvfjz5tOpwW6y6OucOKUJ7hkFi+sJPCfxtH8=@vger.kernel.org, AJvYcCVmaiY/sW6fraeAmhuIsFW95pRQfjhp7csubUPSY6/F3sdR9MFVU+MyTKmfJ1juIK2ixaVIzNztWZBvjeOxHkDb@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc5EUwD129sZ1ylzNI6Q69u6f6njrbCzRLOji8qE7r45f9G1cC
	WAuHHFtg27NHw9JJm4lpD3zZh8ttjFnKQ8kcLbeLTAPt9k5TEUS9YIE66Q==
X-Google-Smtp-Source: AGHT+IGYTqv3ejoDc8u7yNNJ4oZdbuc34HZWBGEOe2X/BnoG9he+txu7j4n+IMDbvJ5Ix6N14Rdbcw==
X-Received: by 2002:a17:906:730d:b0:a9a:a5a:1d47 with SMTP id a640c23a62f3a-a9eefeb27a3mr710647666b.2.1731178469358;
        Sat, 09 Nov 2024 10:54:29 -0800 (PST)
Received: from [192.168.178.20] (dh207-40-48.xnet.hr. [88.207.40.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a17b58sm398923766b.25.2024.11.09.10.54.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Nov 2024 10:54:28 -0800 (PST)
Message-ID: <56998f22-004c-4629-bd8b-8b494290f787@gmail.com>
Date: Sat, 9 Nov 2024 19:53:32 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>,
 Antony Antony <antony.antony@secunet.com>,
 Cupertino Miranda <cupertino.miranda@oracle.com>,
 Artem Savkov <asavkov@redhat.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Mirsad Todorovac <mtodorovac69@gmail.com>
Subject: [PROBLEM] selftests/bpf/progs/test_tunnel_kern.c: 678: 41-47: ERROR:
 application of sizeof to pointer
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, all!

In the linux-next tree, next-20241108, coccinelle found an error.

In the line 617, ret = bpf_skb_set_tunnel_opt(skb, gopt, sizeof(local_gopt));
In the line 678, ret = bpf_skb_set_tunnel_opt(skb, gopt, sizeof(gopt));

when

 592         struct local_geneve_opt local_gopt;
 593         struct geneve_opt *gopt = (struct geneve_opt *) &local_gopt;

and

 652         struct local_geneve_opt local_gopt;
 653         struct geneve_opt *gopt = (struct geneve_opt *) &local_gopt;

So, in all other call to bpf_skb_set_tunnel_opt(), the third parameter is the size of
the  struct, not the size of the pointer:

./tools/testing/selftests/bpf/progs/test_tunnel_kern.c:193:	ret = bpf_skb_set_tunnel_opt(skb, &md, sizeof(md));
./tools/testing/selftests/bpf/progs/test_tunnel_kern.c:273:	ret = bpf_skb_set_tunnel_opt(skb, &md, sizeof(md));
./tools/testing/selftests/bpf/progs/test_tunnel_kern.c:349:	ret = bpf_skb_set_tunnel_opt(skb, &md, sizeof(md));
./tools/testing/selftests/bpf/progs/test_tunnel_kern.c:388:	ret = bpf_skb_set_tunnel_opt(skb, &md, sizeof(md));
./tools/testing/selftests/bpf/progs/test_tunnel_kern.c:617:	ret = bpf_skb_set_tunnel_opt(skb, gopt, sizeof(local_gopt));
./tools/testing/selftests/bpf/progs/test_tunnel_kern.c:678:	ret = bpf_skb_set_tunnel_opt(skb, gopt, sizeof(gopt));



===========================================

 587 SEC("tc")
 588 int geneve_set_tunnel(struct __sk_buff *skb)
 589 {
 590         int ret;
 591         struct bpf_tunnel_key key;
 592         struct local_geneve_opt local_gopt;
 593         struct geneve_opt *gopt = (struct geneve_opt *) &local_gopt;
 594 
 595         __builtin_memset(&key, 0x0, sizeof(key));
 596         key.remote_ipv4 = 0xac100164; /* 172.16.1.100 */
 597         key.tunnel_id = 2;
 598         key.tunnel_tos = 0;
 599         key.tunnel_ttl = 64;
 600 
 601         __builtin_memset(gopt, 0x0, sizeof(local_gopt));
 602         gopt->opt_class = bpf_htons(0x102); /* Open Virtual Networking (OVN) */
 603         gopt->type = 0x08;
 604         gopt->r1 = 0;
 605         gopt->r2 = 0;
 606         gopt->r3 = 0;
 607         gopt->length = 2; /* 4-byte multiple */
 608         *(int *) &gopt->opt_data = bpf_htonl(0xdeadbeef);
 609 
 610         ret = bpf_skb_set_tunnel_key(skb, &key, sizeof(key),
 611                                      BPF_F_ZERO_CSUM_TX);
 612         if (ret < 0) {
 613                 log_err(ret);
 614                 return TC_ACT_SHOT;
 615         }
 616 
 617 →       ret = bpf_skb_set_tunnel_opt(skb, gopt, sizeof(local_gopt));
 618         if (ret < 0) {
 619                 log_err(ret);
 620                 return TC_ACT_SHOT;
 621         }
 622 
 623         return TC_ACT_OK;
 624 }

 648 SEC("tc")
 649 int ip6geneve_set_tunnel(struct __sk_buff *skb)
 650 {
 651         struct bpf_tunnel_key key;
 652         struct local_geneve_opt local_gopt;
 653         struct geneve_opt *gopt = (struct geneve_opt *) &local_gopt;
 654         int ret;
 655 
 656         __builtin_memset(&key, 0x0, sizeof(key));
 657         key.remote_ipv6[3] = bpf_htonl(0x11); /* ::11 */
 658         key.tunnel_id = 22;
 659         key.tunnel_tos = 0;
 660         key.tunnel_ttl = 64;
 661 
 662         ret = bpf_skb_set_tunnel_key(skb, &key, sizeof(key),
 663                                      BPF_F_TUNINFO_IPV6);
 664         if (ret < 0) {
 665                 log_err(ret);
 666                 return TC_ACT_SHOT;
 667         }
 668 
 669         __builtin_memset(gopt, 0x0, sizeof(local_gopt));
 670         gopt->opt_class = bpf_htons(0x102); /* Open Virtual Networking (OVN) */
 671         gopt->type = 0x08;
 672         gopt->r1 = 0;
 673         gopt->r2 = 0;
 674         gopt->r3 = 0;
 675         gopt->length = 2; /* 4-byte multiple */
 676         *(int *) &gopt->opt_data = bpf_htonl(0xfeedbeef);
 677 
 678  →      ret = bpf_skb_set_tunnel_opt(skb, gopt, sizeof(gopt));
 679         if (ret < 0) {
 680                 log_err(ret);
 681                 return TC_ACT_SHOT;
 682         }
 683 
 684         return TC_ACT_OK;
 685 }

SOLUTION:

Fixes: 5ddafcc377f98 ("selftests/bpf: Fix a few tests for GCC related warnings.")

------------------
diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
index 32127f1cd687..b53d367451b2 100644
--- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
@@ -675,7 +675,7 @@ int ip6geneve_set_tunnel(struct __sk_buff *skb)
        gopt->length = 2; /* 4-byte multiple */
        *(int *) &gopt->opt_data = bpf_htonl(0xfeedbeef);
 
-       ret = bpf_skb_set_tunnel_opt(skb, gopt, sizeof(gopt));
+       ret = bpf_skb_set_tunnel_opt(skb, gopt, sizeof(local_gopt));
        if (ret < 0) {
                log_err(ret);
                return TC_ACT_SHOT;
--

Best regards,
MT

