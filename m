Return-Path: <linux-kselftest+bounces-17080-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BEC96AD13
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 01:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA4041C24399
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 23:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E6F1D58B5;
	Tue,  3 Sep 2024 23:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQ3x1OBK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F3D1EBFFA;
	Tue,  3 Sep 2024 23:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725407541; cv=none; b=qy3nT0D1Wki8g+G1KeduI7/Gn3XYhJTsC7TTGMrlQ0uWAO8wS0d1fYYpADKbePI8a001efmIo/BpKg9+Il74DBr4+m/1lx04YkIWrSL+TqRCw2GH7sleYdyJuRgV9dEbEkQaMMSeBR6w9ICgwcgjTRKyA48EPNZ9U/dm2N5mtTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725407541; c=relaxed/simple;
	bh=Rc+LSc70d4AplQJyJ0M1PIXuutNFzZXPysC7XLw2Sqk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/4MlYvp0oW6+6TQWx0ka6lim+XcrSLVeg6u8pSMJ/TTQHqUaqKldqlsA97ppb/atysb5LXceIgTaKsf7pygsAFnuCv/AYDfx2TIwYJGVvobOd4Z6HIIkXfuHc5WV7W+mwO7ZfkLFzTt6WFT+3HNE7N5xjy2jeUKZzHGS7vHp/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQ3x1OBK; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7cd835872ceso4089205a12.3;
        Tue, 03 Sep 2024 16:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725407539; x=1726012339; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DPNO5N4+9xfBeJu418CBvO1tBm6F+BZmSva4endPkkg=;
        b=jQ3x1OBKDcYROY/Sv/IHb22p5pWNTmpsvImq1c6pCAcQTJvND2mneECxqWRQ/+u2Wa
         kITRJjyiJhAvVHqjdhX4TxAPKkD7VJvBWU60IvUGlqGhD/pUtkqIt6EYWHaJvvvfgDOz
         5x+Ck6ehTB2/ndTSoe+UMJAp0ahGXnWReSukIpr6Jr2cMOJ60TeSB0Pe1gwqDVlh3qzI
         34L4TX5KkcLOUlBJAxAOyDT9acbt1XTPiXUEPznLVHyFA7F06qKiSjkTcGP83VKB+BzL
         VUab8chR5SaV1Pks6mJk9OEbAoNaur7SOE0PGPGAAGneez21igETkxHVg/GwXyYoXwok
         htOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725407539; x=1726012339;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DPNO5N4+9xfBeJu418CBvO1tBm6F+BZmSva4endPkkg=;
        b=Rf12mJg2+W4mP89kTYPeSqY2PPKT0WR7gLfrRnOQHg01ljwy4CejnhXNGwRINIeC5C
         EibHdDkI3fEGxqBH8HWjZjkiCh+6aGusNX+3Opi3fiaCdLlYjh0dIBFRStSMZ2gF+XMW
         ClA5+QiL/mwmpy3mDCCMuiCCL9v5UG2eAEN2S3OWzfPI0rOSxZBoVvg3yn1N4dWuiTPb
         E1K9sJaRcf/34/k/xi8dUuTjHYPmmGmg6hIpmyzvj6kMcKxuSkB012RqgPy7eDYleCv7
         UjLQxGUyzfKMBTlStSyJ8NZVG0xC06WjkMGeX20FNQ2TP0r6touk8rsnOPumiRPTUcI9
         a8cg==
X-Forwarded-Encrypted: i=1; AJvYcCUOxf46sCcgmUIoUHNEHowgqA5wTND2cwqVjByrUIh3+fk2IH9EFFwjGDPNs26O2/lksWHYkDSNzeroyT+iwts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc0sjEbUofEgb/+khPGvv8BS6ZAaGNF5o6GmMrcwrdTWANI+ns
	JR3ZuMO/AHK0JkAcD4RfwKiXHZZSnEwMZ2zWXLx8sMRy8da4GVjA
X-Google-Smtp-Source: AGHT+IHJLokfEJGkXlSNIen638fNaPmPP1dVAFyDG92LE7LOuNQ25pqo2VEBvRPY51a+LuAFZ1GRCQ==
X-Received: by 2002:a17:902:dad1:b0:206:a162:e18e with SMTP id d9443c01a7336-206a162e345mr36605245ad.25.1725407539286;
        Tue, 03 Sep 2024 16:52:19 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea65b54sm3409345ad.243.2024.09.03.16.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 16:52:18 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Tue, 3 Sep 2024 16:52:16 -0700
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH bpf-next v5 7/8] libbpf: Support creating light skeleton
 of either endianness
Message-ID: <ZtehME2iZOzrLaNU@kodidev-ubuntu>
References: <cover.1725347944.git.tony.ambardar@gmail.com>
 <2b2895eaf3c6ce53397c9d4c8f53d94dd817b398.1725347944.git.tony.ambardar@gmail.com>
 <CAADnVQJeQvKJeJpJVh1BkrkHeY6WOaNFTh4sru-H3=ecO=qd5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJeQvKJeJpJVh1BkrkHeY6WOaNFTh4sru-H3=ecO=qd5g@mail.gmail.com>

On Tue, Sep 03, 2024 at 12:57:51PM -0700, Alexei Starovoitov wrote:
> On Tue, Sep 3, 2024 at 12:34 AM Tony Ambardar <tony.ambardar@gmail.com> wrote:
> >
> > @@ -1040,10 +1121,11 @@ void bpf_gen__map_update_elem(struct bpf_gen *gen, int map_idx, void *pvalue,
> >         int zero = 0;
> >
> >         memset(&attr, 0, attr_size);
> > -       pr_debug("gen: map_update_elem: idx %d\n", map_idx);
> >
> >         value = add_data(gen, pvalue, value_size);
> >         key = add_data(gen, &zero, sizeof(zero));
> > +       pr_debug("gen: map_update_elem: idx %d, value: off %d size %d\n",
> > +                map_idx, value, value_size);
> >
> >         /* if (map_desc[map_idx].initial_value) {
> >          *    if (ctx->flags & BPF_SKEL_KERNEL)
> > @@ -1068,6 +1150,8 @@ void bpf_gen__map_update_elem(struct bpf_gen *gen, int map_idx, void *pvalue,
> >         emit(gen, BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel));
> >
> >         map_update_attr = add_data(gen, &attr, attr_size);
> > +       pr_debug("gen: map_update_elem: attr: off %d size %d\n",
> > +                map_update_attr, attr_size);
> >         move_blob2blob(gen, attr_field(map_update_attr, map_fd), 4,
> >                        blob_fd_array_off(gen, map_idx));
> >         emit_rel_store(gen, attr_field(map_update_attr, key), key);
> 
> I don't see the point of two pr_debug("gen: map_update_elem...
> just a few lines from each other.
> 
> Other than that:
> Acked-by: Alexei Starovoitov <ast@kernel.org>

Thanks for reviewing, Alexei. I agree those could be consolidated, and I
tested the following patch to do so. I'll include it if another respin is
needed, or someone else could modify during merge otherwise.

--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -1124,8 +1124,6 @@ void bpf_gen__map_update_elem(struct bpf_gen *gen, int map_idx, void *pvalue,

        value = add_data(gen, pvalue, value_size);
        key = add_data(gen, &zero, sizeof(zero));
-       pr_debug("gen: map_update_elem: idx %d, value: off %d size %d\n",
-                map_idx, value, value_size);

        /* if (map_desc[map_idx].initial_value) {
         *    if (ctx->flags & BPF_SKEL_KERNEL)
@@ -1150,8 +1148,8 @@ void bpf_gen__map_update_elem(struct bpf_gen *gen, int map_idx, void *pvalue,
        emit(gen, BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel));

        map_update_attr = add_data(gen, &attr, attr_size);
-       pr_debug("gen: map_update_elem: attr: off %d size %d\n",
-                map_update_attr, attr_size);
+       pr_debug("gen: map_update_elem: idx %d, value: off %d size %d, attr: off %d size %d\n",
+                map_idx, value, value_size, map_update_attr, attr_size);
        move_blob2blob(gen, attr_field(map_update_attr, map_fd), 4,
                       blob_fd_array_off(gen, map_idx));
        emit_rel_store(gen, attr_field(map_update_attr, key), key);


