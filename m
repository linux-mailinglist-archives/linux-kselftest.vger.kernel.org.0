Return-Path: <linux-kselftest+bounces-28071-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79033A4C596
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 16:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAF5C3A2F1C
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 15:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E35214800;
	Mon,  3 Mar 2025 15:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPBfQZTX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DF6200BB7;
	Mon,  3 Mar 2025 15:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741016849; cv=none; b=bs/qeL2oNFG8cqB2XnW7PfjdhhnLnHMLM9HbVLO1CkNZQIutwOyZhwL+6bE/JuBFDWbVylMZ0Pa1PbXt8sWePaxTBSB1yZaRAmXwEM1m/79OiEhTlwvT06CXUTxDSt3fI5uN36HK1CHrnqcjGZGLdfT3tYQbfyWpt/Gm7JrMAN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741016849; c=relaxed/simple;
	bh=Ow8lrxe0PWKMLpHXKUtXOFBjPojMYBHA6vvjiBL068w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khbA8Z0yO8N+JbIlhoDJQELIFOp6GWiMa2jQIFGc0CEBzAZO8K1E304F1fWKV+HOImC9UaLBmWv8AkUFjZ23SJEk5vH6tRnaIv5pYq6vtrxFOwUoG+9J5vNMUGDt1/2Y8JD1Yk8zefx8tcF4nrW564KDby1NAuwucMp/Z7pPZrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HPBfQZTX; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2234bec7192so67599695ad.2;
        Mon, 03 Mar 2025 07:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741016847; x=1741621647; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fuGkriKnbZ9KpJb842PUOdt+nMHlOXh/j/2LJMtEZug=;
        b=HPBfQZTXWbnTO/vKOgyCJIalE5L/Te/sCSuK1Qtw6YJWh91chk/VcgX9Kq7Bp2Igpr
         ONoFoW1pgkiZuP1cMf67veLC/UL+yHI/dPZgzJ2Yh/c9xC3I+QRsAcPZC44xm+vbf9hL
         H7L+B7x+2p9FxxshTrLlL51uDVyOQbTjoXPRc4Fw9kQk/zzjxQuJiW+EC4+9obUVACgG
         TTdUwfl+sGcpO6k4EcFzozLKCh5SfgDfmLUSGnBWR0Tpt8g4zpssQ303svXRCn5DJTd5
         fGts28M8IRo96mEGsdRfogv0OutW4C2/JXP8KtukP2XpQnSmbG/OLFs8KZI5scmr0eQl
         wn7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741016847; x=1741621647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fuGkriKnbZ9KpJb842PUOdt+nMHlOXh/j/2LJMtEZug=;
        b=S+0axR+dWOwwoaHgVSaUY1zhPJeFZzmVsMWmoVdiH8JUjyFqjq5+xOyNTb1BElamoD
         z9VNKbBFeLXEyUc3km+3Vd15poqJAr1X9dzJXReYmI/e45vPP+1/PY98B+jis7SID3c5
         lOXyl7arhTKFnJeFry7cPgtPwlm8qb0hNvfgIy6uPNOvhPNAbl6KnzBOwS2Qba6u5ijr
         NAuCmYa2dfVTTECr25Kw1o8NGI+Ufpf/OV1n2TlZXVebFQVGWeYR2TQbkyxioMiJ92nj
         uwdF6oZgZ7e1LNQ2kiiM8bpJtPL/VkcdDIM16NNNed7GcwTd8IZNDnkKmTZh/CoRnbN4
         XZ4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVMtDJAVJs4mtHPRdmHEystA0x4XTfJaNmQ8X15WiUjGxvdUQvOYcnhocu/1uzURTR9hMpT1X1UpNeYUsOs@vger.kernel.org, AJvYcCVSZIm+IGZ+d0eB9UuRJFoD+Bf7RPckqKmLIOc4vp39pu1scpMykBTnVOV32ENZ232FGzE=@vger.kernel.org, AJvYcCXU6BXoL8bVDbaew8DghNOpB7q7JDsXaGEBucWSgAY9PvaViNq6BSmfG9hKHtuFM6zrsL2nMtxxLj6G3L/6KEJw@vger.kernel.org
X-Gm-Message-State: AOJu0YymEKXbjIHhlvnWgFsz1Llusx3YMa7X9Ow2hhKv3XCyMWXPJ0bp
	VG8u+eoQAhLyH53Il6tk0+hPMcZCxNGnLsA4WvdH25GQgSiMoCo=
X-Gm-Gg: ASbGnctAy7JbwPT++1ps9A0NloRYrTEA3ZuseMM8oIi+gKxOoh4vkXP0uQwl8WCatD1
	pFhqA9UpnqlRMFb7Au7JzPr00ldugjQardsm8KDkjUOqSiTPBmI+kvVriFl9cGRybSvsny2ESvo
	zPAB79cL3K5ZBPuXakwCptd8G6bgLG0IWc50bRJGCMfjyxe9RSKn3PyxNW4+N32eEeRy1dfg4/X
	3RvmdeSEIGvvrVsgSp0yVwJ7hRjoM0s9jMXIeRuY/+nVJ5Z/UdA29M+PI7XKyftaTWljDsnhJEw
	0gPIUMVN2OMUAjZb8L1kid8w5MdzjutktleyKb2iNHKh
X-Google-Smtp-Source: AGHT+IGrMRYWsWOFL3Kw71K/ypUf3rQa24lg6YJT6yUBLETZm55ucadiubufeT6owmr/M//8IU0A9w==
X-Received: by 2002:a17:902:dacf:b0:220:c178:b3e with SMTP id d9443c01a7336-22368f748bdmr207262915ad.16.1741016846994;
        Mon, 03 Mar 2025 07:47:26 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-223501fae0esm79281605ad.93.2025.03.03.07.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:47:26 -0800 (PST)
Date: Mon, 3 Mar 2025 07:47:25 -0800
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
Subject: Re: [PATCH bpf-next v2 01/10] selftests/bpf: test_tunnel: Add
 generic_attach* helpers
Message-ID: <Z8XPDehCudlWBAWW@mini-arch>
References: <20250303-tunnels-v2-0-8329f38f0678@bootlin.com>
 <20250303-tunnels-v2-1-8329f38f0678@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250303-tunnels-v2-1-8329f38f0678@bootlin.com>

On 03/03, Bastien Curutchet (eBPF Foundation) wrote:
> A fair amount of code duplication is present among tests to attach BPF
> programs.
> 
> Create generic_attach* helpers that attach BPF programs to a given
> interface.
> Use ASSERT_OK_FD() instead of ASSERT_GE() to check fd's validity.
> Use these helpers in all the available tests.
> 
> Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

