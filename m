Return-Path: <linux-kselftest+bounces-26146-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C048BA2E540
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 08:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DA6A166501
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 07:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E521A4F22;
	Mon, 10 Feb 2025 07:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="W8drf9h4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999091922F5
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 07:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739172158; cv=none; b=cfoRcNtNFnhEYFGs+pIl/TNK32G7BuZ4ZwL6EJO9yoUqRIiSWZZB/KV7rbfYfabbz6S0wAwmHet5ora251oQLGLExaBrLcVyK7CsNlQUb4KvL9s7hcHUOSI+tNnlLjhFLhzvH1fxPVYxGUz758I8Pxz3zL+dBysdcIUKX4yZfg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739172158; c=relaxed/simple;
	bh=Fq7AOqywtozLGyzDhVRKESkoXd49xTjrcIyMW3nGG/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CoRpr5fNIZ/Z2PIr1WGHeRc2Qdtexupl0vlXaVGLUtYCVeQV+KordcUxT2zFCWOQEPzRGIRKnmwGRQsBjwoIAmsJ/wBDp5dsafKky8GYCY4GVrb98EF4flXYmnkYW8nawcCimK1Ia0/Gc1Z8TraGfn+kdTdFpHMtCzEWXWkAgwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=W8drf9h4; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c061d7bad9so22552685a.2
        for <linux-kselftest@vger.kernel.org>; Sun, 09 Feb 2025 23:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1739172155; x=1739776955; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2eifM2TJgSxcTeM2vc1cnmxmV71PALyO8f+gK0jI++w=;
        b=W8drf9h4j2l7W+FWvCLfUTf9EGst8FOk5l/3T+J6ICTl3A45vdlVbpEp3RznvCA6Rc
         DijWqsFFhngXXyZ0skLOGCsEniR6ag99tIihIdA6rM8VSqRQUw9nzffzGQFWVFcd8O+Z
         7z0iLWkeMN8McnOALFs5ymYnCPMIqjfOpK2i18a6YAykyfslgI7GVD+NgPnq+lZfrH34
         Qk/dxATBaGY90WLbdRB3otqVD2rqSuhZlhoLeG92FWS/e2STbA3bcAujJ9gdgFP28Gwd
         QWkS+CeVJ1W0AZ5u2NgNoX7Rg/gDz516oGIz+hxo3XrpQ9MdYPoiPphhboQeHFmRYCMw
         EHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739172155; x=1739776955;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2eifM2TJgSxcTeM2vc1cnmxmV71PALyO8f+gK0jI++w=;
        b=Uu2b/vqKhotSL31ezT/R18EBho06O+tchnNY6DN/LfjLrH7lzdaRHBBw0Yx3QHYnbp
         WsIgVrLLDNDT1I/wx9zlSKiUeXaQct+XSW27rZu5SWTy8g4a8d2MfgXZ8wTSQtexxv80
         rIgIzfJjj7Ejhv0DY5SzQogjqjkxylFRFOoSDBXwJRw4dWHdFnXoNZKdazv49/v8Wb2c
         463DzxaCtl1vnLE5ISpEDyYIswEdZuHoq8fXg9vpJe+3RAxnk++E0LCm1Mg/R3Dbavvj
         GkN5z48GbdwzsP09BpPQMo0BhXulmseEK2u/iF45wDvAwEEZGaema95LWFsR8oeGMKyY
         gu4g==
X-Forwarded-Encrypted: i=1; AJvYcCVzrTH+yxmRueRWzSYu+/XN6F5jjKPapD+Tta4la+OH3zy1z715B+CIfXxLyj7+KLpsyR+bKa32fGC2eG4y4qs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0kOme+rNyIfH2Vaiu4a3NK8UjPf8r3//lt+HCTDX8TzW7AXm1
	KfhsnShSefjYG1ekTN+LF/tDYQasKTCFf9cL8sAXri7/Oqahwu/6fycvYtLaxMo=
X-Gm-Gg: ASbGncuWoF31+Tf2J9Xbo0Js6BNGQFNoZhcFSJpjW62K4peUH21t3vQETEax9+dq0St
	D6c07L3/Ranmurr4Jb6dZLLr3YYCznY8lF1gVdsaINCe3vD4JtPB7DK7k1n15tD1wUC2V6RXl4M
	OwQncVAWW1T9AGDhk6huH056HBEUoh/1xjFXNEfAHhRDEXEQx5TJKB/8e13aLkGLTiuGY1m1h1v
	Hxoiu18ZEMSIU+ATmYNLPzQZMplgMLhbx31z0UzoBiOJLHmsz+Cz/YFWIhZgwwiuFrOPCHoMusu
	hGiO
X-Google-Smtp-Source: AGHT+IFqoVnPbfDlA0I7Lpzq5OYGCiuDOBCLRt/SyBPdEZ3hBHFAoO/pSle/c5P109+yMKGpe128IQ==
X-Received: by 2002:a05:620a:390e:b0:7b7:142d:53a4 with SMTP id af79cd13be357-7c047ca7edamr1803066785a.51.1739172155488;
        Sun, 09 Feb 2025 23:22:35 -0800 (PST)
Received: from debian.debian ([2a09:bac5:79dd:f9b::18e:183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041dec31dsm499971685a.1.2025.02.09.23.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 23:22:34 -0800 (PST)
Date: Sun, 9 Feb 2025 23:22:31 -0800
From: Yan Zhai <yan@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Yan Zhai <yan@cloudflare.com>, Brian Vazquez <brianvv@google.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@cloudflare.com, Hou Tao <houtao@huaweicloud.com>
Subject: [PATCH v3 bpf 0/2] bpf: skip non exist keys in
 generic_map_lookup_batch
Message-ID: <cover.1739171594.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The generic_map_lookup_batch currently returns EINTR if it fails with
ENOENT and retries several times on bpf_map_copy_value. The next batch
would start from the same location, presuming it's a transient issue.
This is incorrect if a map can actually have "holes", i.e.
"get_next_key" can return a key that does not point to a valid value. At
least the array of maps type may contain such holes legitly. Right now
these holes show up, generic batch lookup cannot proceed any more. It
will always fail with EINTR errors.

This patch fixes this behavior by skipping the non-existing key, and
does not return EINTR any more.

V2->V3: deleted a unused macro
V1->V2: split the fix and selftests; fixed a few selftests issues.

V2: https://lore.kernel.org/bpf/cover.1738905497.git.yan@cloudflare.com/
V1: https://lore.kernel.org/bpf/Z6OYbS4WqQnmzi2z@debian.debian/

Yan Zhai (2):
  bpf: skip non exist keys in generic_map_lookup_batch
  selftests: bpf: test batch lookup on array of maps with holes

 kernel/bpf/syscall.c                          | 18 ++----
 .../bpf/map_tests/map_in_map_batch_ops.c      | 62 +++++++++++++------
 2 files changed, 49 insertions(+), 31 deletions(-)

-- 
2.39.5



