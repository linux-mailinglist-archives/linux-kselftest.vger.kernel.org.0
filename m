Return-Path: <linux-kselftest+bounces-26906-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DAEA3AAC9
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 22:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 691F816A60B
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 21:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8DB1C6FFD;
	Tue, 18 Feb 2025 21:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMRfW8mV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074141C6FF8;
	Tue, 18 Feb 2025 21:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739913770; cv=none; b=aci43Mvbjf9P1Az5w2SzSzmuayqlaZqf3N69X1LWYRXfup2Ryokh7tatqisoJ2swqbNOP7TIimvfnadAXCcTf5cmdFimmnGBh9gozKrGcjQ1Fp4TttLAUqiFmx1Y/bL/yTCH3ZIniLqEmc2rimV/+bf0UkyqTl0jaTHHqcr4FeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739913770; c=relaxed/simple;
	bh=mO8/OX+TtD76PNCNMzPQnEVym+SvzLwOvgdAPrx2c0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cWqH2JcUWRHMEs8DzAB+32gOd6KL0CHcRvBQ0WB8cguR6C6jLFFZw95OalS6UEcQJ9DF0GHnmwKkCFWrbZWE3XNU2bZ+0IbDR8JMTxkfZDT5ivhycc17dR1MDQ3LaEgCe4nePRF98bgTbawGEfwKAVi6OvXyobS3HhRXdqu/yGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jMRfW8mV; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-220e989edb6so120581425ad.1;
        Tue, 18 Feb 2025 13:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739913768; x=1740518568; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MCGLcaBsKIeSx5CrPCdbLx3FeDWUDA+FDmgXn6o6EGw=;
        b=jMRfW8mVacTmPJChXGxt9gj4vDwAZcFsKXMFXBCDaVFByjyQeESdpy62umQ0/4P1pT
         GkXWj+Lq/CkAlL+5taXmUHOjKw2MTXVG4f6DRidAtN58nm7L1TaV1aomAobkdJDLYOFS
         UlgOBE7K0bfNyaxMKFYhlp/SAPRwPPC12S+z6aB3tKPDmx0x9joDtEIb4Z1OGfNyJYRc
         EGkwhy0jN/lQezjP4ynCUPqTKp+SRVhi50jhWL3azJtzM8tBvjaaesYXyEa5TFAw7B/b
         ItOjjEHLSzQAQ2LF3rqvnAAKPJWWzhAfuz7bj663A24O7LfY+C7weqHr5uT3zloKiJSc
         A4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739913768; x=1740518568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCGLcaBsKIeSx5CrPCdbLx3FeDWUDA+FDmgXn6o6EGw=;
        b=uA9Fqz5oHW5Dsh2pD1maehY57yB3+2iu6ZNI42zjQeAvGX76ZJyDoroPZtUYNPQGe4
         /GscLHZwUaIkYbZWg2uaVL1nl2LsKip+2vdqoZ3rp0BHjmdIHxz8h1+3/c1tsZy43EPd
         lgff80lVo+gN+dzaHaYbttDcUhi5elnlqA41ImB0KuN8c7/wtDanKZmWwwjnc+e7CaTx
         PM6Nd4+rN8dRrL0ZMAIcH53H1w9h1YLeMDHffwgRHcTYTh0U5+2LfiVMmd4WdP7R1u9U
         aJjRz0n5nL1Elm71Wwx2xJsRx2GJ8wpByaDrJ34zqfQiDSICryWCd98U7Tc89hmZNbpU
         Xblw==
X-Forwarded-Encrypted: i=1; AJvYcCVBu7/w2h/6MC3MJD6dzRmVcg2rYGY8VKlK6EsICxJ+gNttqtvrJyDy8HWN0ZOiw+v+ZAY=@vger.kernel.org, AJvYcCVWQnlpHZIZeVvDl9pfztkwQML+NQo1Z11b9frdT8IkUdQN+HuHrGmTdTQy5lu3nLsSHK3DaONXD+63tQ0r@vger.kernel.org, AJvYcCWyIizNYZZ5qi31qq3fl1PejoH2IrfPdmZKmaLL89tKZ109ZvONDIeC8BFgKZkBgwKaYTo/q915yFPmjqawhRtX@vger.kernel.org
X-Gm-Message-State: AOJu0YxOt5o+UrYjxMmgdBPo6btHf5QHlgA3S8QZTbu7nD5m/0c6ERe7
	T+yVmLOMGuVx+nlb5KmVmLue2K6cOy0LYZQ/i9+7DPx7P1hzXFM=
X-Gm-Gg: ASbGncvqYtWkwT8kZEhhvPD2KHbnBskYvek9WEjiUj6N5U+Mkg0oMmODGiuAaGvPtWK
	tflIYBBkLS8pzPlp9J4KtqDIhfD2wWiZDhFXl8Nk97pNI/Cq3HfXdkwwZ0kjfsKeWT6c9Uh2D0U
	16aV66H4wyjYMjj2jwJgGMEmJiizmJXtWp6ioADwpcyG8uT9BgAd9K7SeFpoWUdJuilNGtKbV2Q
	6FoEfoWT2D/gMeCv3Ca7qp6Q3OjOY0QePvnczZLyL1Crwtt/QcSQdYFiYHs+1JAaWn/tlAQ8/IK
	ZLyqRsAp/tSsq/s=
X-Google-Smtp-Source: AGHT+IFvRiZC16m7YP1vm9kCqjs9N5vCdVDj1JD3GUfBrBolSBWqxE9kNWL7zcEGz/Ex8QCXBrSg4A==
X-Received: by 2002:a17:902:f54f:b0:216:4d1f:5c83 with SMTP id d9443c01a7336-221040bf8dfmr257329635ad.47.1739913768239;
        Tue, 18 Feb 2025 13:22:48 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d5348f1esm93375405ad.51.2025.02.18.13.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 13:22:47 -0800 (PST)
Date: Tue, 18 Feb 2025 13:22:47 -0800
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
Subject: Re: [PATCH bpf-next 0/3] selftests/bpf: tc_links/tc_opts:
 Unserialize tests
Message-ID: <Z7T6J4BpIrBcsWPM@mini-arch>
References: <20250217-tc_links-v1-0-27f7965e3dcd@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250217-tc_links-v1-0-27f7965e3dcd@bootlin.com>

On 02/17, Bastien Curutchet (eBPF Foundation) wrote:
> Hi all,
> 
> Both tc_links.c and tc_opts.c do their tests on the loopback interface.
> It prevents from parallelizing their executions.
> 
> Use namespaces and the new append_tid() helper to allow this
> parallelization.
> 
> Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

LGTM, thank you! Optionally, if there is more to convert, we can think
about moving create_and_open_tid_ns to the test_progs itself. For example,
if the test name starts with ns_, test_progs can probably do the
create_and_open_tid_ns/netns_free part?

