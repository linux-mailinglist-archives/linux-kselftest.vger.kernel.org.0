Return-Path: <linux-kselftest+bounces-30028-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD6DA795F8
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Apr 2025 21:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF2D21732FC
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Apr 2025 19:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A3D1EBA07;
	Wed,  2 Apr 2025 19:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="JfTtlCRv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f230.google.com (mail-il1-f230.google.com [209.85.166.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33A77DA6A
	for <linux-kselftest@vger.kernel.org>; Wed,  2 Apr 2025 19:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743622463; cv=none; b=LxWqH4OSWXBJrbtZS1GDNnQqvw2au8frmv6D75HfwyyMBtF3DujwfKY2lzLfzQ1Qy+2xhiDTqtomwam/6i9yyqwAmBfe+d8U7d+KTUQzcQPZq5akVtGOfa2yjd1IM3/BoefdlQhWdJgTcPRdkOnpPUaIlgbeTuBtLMGLnC3CUJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743622463; c=relaxed/simple;
	bh=lV/SwxkHMDeoIBtMKdT8vjsBHGJhbLBdcHJ4C+0jMMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZokIYlnT/elEkYiiolsBnoMY7TAZzhnEfOa1JqiN41OwbJ8L9OpgKRUmI0nTLl+/MslXha0LuFxrnYTXrDJGBmPWHlLN103Fk+iD+Gc4VHyeyn6TBOyz7GhC7BITem3JtgoNiA8JPMsIP+s/dHQphGGdQdPDyA0hqd1tkBVWkZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=JfTtlCRv; arc=none smtp.client-ip=209.85.166.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-il1-f230.google.com with SMTP id e9e14a558f8ab-3d5e68418b5so1676725ab.2
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Apr 2025 12:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1743622461; x=1744227261; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RaIhuSmEG2G5gRImcsA2An6Xyo4MZv5/cYCExcMzv5I=;
        b=JfTtlCRvLM+P92rFUbnlT6JHjq9Pcc503XyB0KT4YmnhdWISk1L7p7b9UIghw93Lwn
         rgOCeOBsqinFAlCrJAXkxUrd8sa+mfoz3+bCVr+pXJekHN4Ge/ol5f2DegQbVUwyJg2Q
         344btZlxS6fTFQIeUz+yCDC+8sDGMoZ4xaJaPDXbHfBAUP2bOWE7H/lWCTyuoU2pIO1r
         aeYiGbNGd1yDdOc3bHboKeVDrBu4kboKvu54rcJzA46OvEwpS1jwPt4m1lEF5pxx5p6t
         XDzYA0udK5cSAvt6hG5mzyBPJu/34xUhDXfGryY/2akRZ46LH4UVU8PwL2v93+3kGWc1
         cZmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743622461; x=1744227261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RaIhuSmEG2G5gRImcsA2An6Xyo4MZv5/cYCExcMzv5I=;
        b=vxm3qplOi3gwam0VdoihTkXOPuF+y9BJjR09d3vZ2d7bbYi6yqQmOgRfgHdvmecNWI
         gzIWJzCk2lFMGgbolCi808iSyudpUdoeB6ako85l9UpUpcjKA6wbLjo/5WKJmK3XiHGY
         LbPZJ0o20lGon+ZpATtL4EPif3ptUns1F+v5cvaLxvspc0kJWtvM2fh69IPW/zkJjny8
         rf4yYnUycCZeGQVC5H7hkJ0OA6G/O35I92TsclUKe/MKShz0XMFqHWUzKiDsmWBtqnG1
         Y9m6pMFbGf9y2/tzjSJ8m4mqxdUxxrpIIp/8bexFeEPPyg2iQeUlD1P1uccB2dfpcxw6
         sTkg==
X-Forwarded-Encrypted: i=1; AJvYcCVt/02tHl6uKbO4JTjzACCL0qFmbm9KzRVwxGnxstH/rUEgshyw0OPfRDEiaMPvilXGifyiK1ZaD6uGDDDS6Qc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKqBDQyBinaKoKUzOf4ixsdjHnMmrYCujXw88/66iMzC/+1Vm0
	5S6bWmTnykTD31AbF9OQXEkS051DLAeEEozQo//OslqgmdlwczbcP5pX1FJKl06bjENI08Lhs5t
	0Vfiszqy4mgNGaHPhbWlpXaIWPCP0IswV
X-Gm-Gg: ASbGncu4QNcq6jWnCe6n6sYt4VO85SQmBeyKPOnnkHAYiD94cBbHEc0uD5KEHH+6PkP
	n1gQJ4aL26FFoJa2OgH+f6uf6k8vSWzlMXDKZ9GIs3G4DOBK+qb+kWhdbbGRK81MwM/M3+XSPKy
	dwZYOOZuXGEGJDoW09JBZ4YD1/P/KSw+w5clVh0VK7+xv+KC/iJ0QMzmeUZFBFaTia1dtGfCK18
	j2YbANkCULIe8ceAwvm0bav1Gd9j/tgtthZND9zAacGYLpWt8SiJd18MJY/wSiSiZ+1ddC1eTNf
	ZdwIwJ9HEXUZiLU8YQwoQ7A80OiiC55BTL/Df7Wn3oRzF25+aQ==
X-Google-Smtp-Source: AGHT+IFsAD207aygo+0nztSrAWlExKIbT6EOMKflxaoI+jAMbF2RFZ0fWIRVrELjJbRzWc4ygH65qwEhvjnZ
X-Received: by 2002:a05:6e02:17ca:b0:3d0:4a82:3f43 with SMTP id e9e14a558f8ab-3d6d547edfbmr43005475ab.5.1743622460924;
        Wed, 02 Apr 2025 12:34:20 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3d5d5a6d972sm9687095ab.28.2025.04.02.12.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 12:34:20 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 3ACB0340186;
	Wed,  2 Apr 2025 13:34:20 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 2CA73E4031B; Wed,  2 Apr 2025 13:34:20 -0600 (MDT)
Date: Wed, 2 Apr 2025 13:34:20 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] ublk: fixes for selftests
Message-ID: <Z+2RPI1GC9NoE/w4@dev-ushankar.dev.purestorage.com>
References: <20250401-ublk_selftests-v1-0-98129c9bc8bb@purestorage.com>
 <174359956539.20480.17105268115889494986.b4-ty@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174359956539.20480.17105268115889494986.b4-ty@kernel.dk>

On Wed, Apr 02, 2025 at 07:12:45AM -0600, Jens Axboe wrote:
> 
> On Tue, 01 Apr 2025 14:49:07 -0600, Uday Shankar wrote:
> > Fix a couple of issues I saw when developing selftests for ublk. These
> > patches are split out from the following series:
> > 
> > https://lore.kernel.org/linux-block/20250325-ublk_timeout-v1-0-262f0121a7bd@purestorage.com/T/#t
> > 
> > 
> 
> Applied, thanks!
> 
> [1/2] selftests: ublk: kublk: use ioctl-encoded opcodes
>       (no commit info)
> [2/2] selftests: ublk: kublk: fix an error log line
>       (no commit info)

Jens, MAINTAINERS parsing didn't add you to this email - I had to do it
manually. Do we need to add you somewhere so you get a copy of all ublk
patches (since you maintain its tree)?


