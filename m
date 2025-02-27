Return-Path: <linux-kselftest+bounces-27798-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7162AA4893F
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 20:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59AAC16D8DF
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 19:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B9026F44E;
	Thu, 27 Feb 2025 19:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8/Pdhh9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAD2225A31;
	Thu, 27 Feb 2025 19:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740685927; cv=none; b=pmtt6h4Ij1mc7nEDuJnzWNznvh6tY0GXRAZbvG7IbwSVpGhK51Rz3glW3gfAKBknpbJP5jZmRoOY1jHJsPTUXD62DVTYB89s4/pYBsNpA8pDt61n0C17jMvndlkL5YiZJYm/vGlNB7B3MZkAdeA1/NhQV8SymR7TwHdo4hWG0EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740685927; c=relaxed/simple;
	bh=M2mUYGXKhlH/pajfrokXLV+OzC2fTGfmJOqbWE7sPrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFJ1g3LZd4BehaNHCkDZKYx5K4wJsqJmLWBUUwKIu1YQJikEfRJw6R5q0580EgmPdeW5e+myMFCIIrJIYfT9yM2dFhR5ayjWi3Dw36OGKgaLCXbzGbU3dNfhvaFcpjvaL11jaIfkWMzlmBnNWPuvq6oVC9vZRFxVbiyrhXK+G50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8/Pdhh9; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22104c4de96so24162905ad.3;
        Thu, 27 Feb 2025 11:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740685925; x=1741290725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q8KgjJM9p04hUyRku/dUxXOL21Qt8EZaQJ5LGtLuHJI=;
        b=P8/Pdhh9HLUvO2IuBO84E520NwxDSXV83y9C9acSA8agWE0OoJqINiMefkYyXNAssV
         23jLPa6A/1qvxApZ493Y+vTD2kpG5MZrgEtJs2iITdSr21wGXFKbArY12xmealByMFBm
         yvjgOPztzVIcds3jubw/JrhQ/PRAmDUiQkH4koahcSbJ52iWJWiFRPc6IKbXGx9CXLOW
         6rhHqwyYOkQgC5NEaRFcz5hORlKvItN4c+04wC5dB8QvG9xsv/1aOSmMmJC0tZwUg2Jd
         HQysCxVkbbmB0VkY4qRPMbeLXndXhDJUF2Xp+IeyW8CLLpmbas2OI8RTgtwpi+jsoNht
         rqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740685925; x=1741290725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q8KgjJM9p04hUyRku/dUxXOL21Qt8EZaQJ5LGtLuHJI=;
        b=CihA41WKgaOsCrPDmjxno/a6U3TTLl6lxeBNhGxkGCPFMCtSZ2s0ss+hZAXDS1mJS/
         kgANpi9piuWM/5DuLzFE0uXReWF1l+1HptxL2eL2BGyPLIUGg4EKqu+uUWRldXIRUju0
         qCQMGyexY6D/HaXT8zhot+4LLlZuMcfAMtHYwgVWD62dMDqKaIm9PWu44pet07bbYuTh
         Plk1XmM9WrBlvIXfcWwdJQofiROgcpoKX+yI3LrnOrHfYqk3TLPChLuG+gJWx+sMY0dR
         CB3Qh9eepV3AlZyj9d5xBcTmoDPxkVAUMpRogwKBrGKReSvscmmtJYTdoIn7bJiHkjBw
         8HpA==
X-Forwarded-Encrypted: i=1; AJvYcCUPqiJZyZJix20PMhMz8URAx8F9CHHeS3bhUK/zxtgdi8R+2TaKaaGYpWqZYQnesl26TRgGmlMaPp1++MKWLAqT@vger.kernel.org, AJvYcCVmoHnUWYURRrwexFS+V5ei+wyIW5W01OqyEjEGdjDSsZArILlDl0u/uHON5T2WgKy6tAU=@vger.kernel.org, AJvYcCWTv6emD8SbhX+WGBaEetX8Ug5Ii7gA9Gj6IqtGKYOacZzMQkdLpyWAEbJc/V1I4TFoN8Jxgu2h@vger.kernel.org, AJvYcCWjp5KFo/gJP0yOeRxxI7t7CsxbNpcnztW+ooNbazaNW+vGZ9NW/kUeW5eNGdCLAbcDYQOfe/+EtNdX8Se3@vger.kernel.org
X-Gm-Message-State: AOJu0Yws283pEKGO/9R5FguXmjaWLT/Vut2UWfb2GupGeTXkq6TaL+oj
	LMUWZ10U2vZWUwxbhRIO0Yy/mpI/w4tNdULIZQHxH5A8hGzX1ZFq
X-Gm-Gg: ASbGnctmIqSav5wgITXMlt1BMcvrYJYPU3qW0UnsJQs7Iiz+Pk/PqXlmQdHO4BBxwPC
	pip57TrTWKs0lpEcWK6RLlO182qui5RLsR4B4tST6SRvOoA78co0AbTzstnO3TP4hE8bQ7WY0tz
	3sUFk12pz3g5TfiRkXkGAD7TbsEzrGKJwhaxpHKyGkZkkjVnh8087zoTqFNnAs7tBgZfLJtKOpd
	TaVK4cfZD3ESmal2MB5sj5etADbSCUaxekHEmH2S/Qf4I1tCOtUHSvp1Xac5vUTXM09ePcxvhHp
	HEboqXffGqwk7eBfRSf3jpQ1ONxN5g==
X-Google-Smtp-Source: AGHT+IF7xb1EoG2t93UVd+aYDUfDsFFyT9npU4LNSJxN3OstzuWY4H6hvcxJWg5zg4Rs2vQqe9xuww==
X-Received: by 2002:a17:902:e752:b0:21f:45d:21fb with SMTP id d9443c01a7336-22368f61965mr5635615ad.3.1740685925406;
        Thu, 27 Feb 2025 11:52:05 -0800 (PST)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe4811fsm2100585b3a.43.2025.02.27.11.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 11:52:04 -0800 (PST)
Date: Thu, 27 Feb 2025 11:52:04 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: cong.wang@bytedance.com, john.fastabend@gmail.com, jakub@cloudflare.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, andrii@kernel.org,
	eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, mhal@rbox.co,
	sgarzare@redhat.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	mrpre@163.com
Subject: Re: [PATCH bpf-next v1 2/3] selftests/bpf: Add socketpair to
 create_pair to support unix socket
Message-ID: <Z8DCZO8n39avsvnF@pop-os.localdomain>
References: <20250226132242.52663-1-jiayuan.chen@linux.dev>
 <20250226132242.52663-3-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226132242.52663-3-jiayuan.chen@linux.dev>

On Wed, Feb 26, 2025 at 09:22:41PM +0800, Jiayuan Chen wrote:
> Current wrapper function create_pair() is used to create a pair of
> connected links and returns two fds, but it does not support unix sockets.
> 
> Here we introduce socketpair() into create_pair(), which supports creating
> a pair of unix sockets, since the semantics of the two are the same.

Since it is only for UDS and only has effectively 1 line of code, how
about just calling socketpair(AF_UNIX) in your patch 3/3?

Thanks!

