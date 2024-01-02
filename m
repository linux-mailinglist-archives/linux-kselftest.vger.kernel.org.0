Return-Path: <linux-kselftest+bounces-2552-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7498C8217E0
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 07:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13A701F21D06
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 06:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C545715D0;
	Tue,  2 Jan 2024 06:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tug/gzpd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D0614A82;
	Tue,  2 Jan 2024 06:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5ce2aada130so1191473a12.1;
        Mon, 01 Jan 2024 22:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704178267; x=1704783067; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R8F/+iXsJjJp5cY3eRGqTDaoPQDTgw92LMUvnxufrxc=;
        b=Tug/gzpddvCSk96Dcmz8qYJ9DcsN8rZKCzAi6itaKSnlrLuGHQozhdgiAeTU1qWRU9
         RMf97AqAmGoOS1/dR/75Z4cvcfJjb/J691V8wybVbZ58jKFaYfasc+n3aYPHr+pQyLAZ
         0R7x8fmzwtkNsL+POCr+WXVqLU16/T35n7tXIONIGCTZJYayh4ncili6a3pqgHxeHfjb
         lpjnsAPvVojU5dcOD77Az4if/4jmi58EK72mFy6uEhvIH5/bKxDkNHZkNz4/fXqk4xDQ
         O8r2Gp7nBB9JV1Ksnxwx65jh60ztD3QHEuPVIHQE+SRJ7uU7td4WbxNypDX884q5S4uk
         3U0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704178267; x=1704783067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8F/+iXsJjJp5cY3eRGqTDaoPQDTgw92LMUvnxufrxc=;
        b=hO8bpeE+Afv+qYID9lt5o3F84pMKRCQg7rsZ5bYAVHlXXxmUihA6Nemycj1ci05zua
         8A2wqsfuLVkv62CQGSS4H96NfC4OpqmkDDet9ltIyp+1KNKpdOZXurlgsE7yOzFl326/
         6AILqsKFU2JyPsBchThAgQ4YdiayB65mDTWfSSsSKC1BgzKCicJOWZHREGG01xoS4ZSA
         ofKy8ittETU9ITFDSVRhU5iNbC/2ejAoGb6+yzNDKbMP8pCkmkopbY1oV1fzWg1TnT2E
         i0M+eywezEPjGp14h33wJKZIB42OV7GBxsCFSapPlpFF8poh88wnn/o18+ud0oJODiuL
         EnXg==
X-Gm-Message-State: AOJu0YydOsDYxmLb6dSi5G7uwpYhCBBU2B0ZqRVqYa+4X+iC5yC8zGBs
	xe77iccxjLmV2FgbHpbrzjs=
X-Google-Smtp-Source: AGHT+IHcTREjpyWgKEzKD4YAHHxNS5f79u2XfsEPNCsjiFswXMxR+qe0BtSk/jJ0gOK+K3RbrdXVDQ==
X-Received: by 2002:a05:6a20:1443:b0:197:1a55:7dcf with SMTP id a3-20020a056a20144300b001971a557dcfmr436231pzi.50.1704178266809;
        Mon, 01 Jan 2024 22:51:06 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id q23-20020a170902b11700b001d4abf0a28csm4714023plr.132.2024.01.01.22.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 22:51:05 -0800 (PST)
Date: Tue, 2 Jan 2024 14:51:00 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Yujie Liu <yujie.liu@intel.com>
Cc: Guillaume Nault <gnault@redhat.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	lkp@intel.com, kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v2 net-next] selftests/net: change shebang to bash to
 support "source"
Message-ID: <ZZOyVGQ7U3K16wHr@Laptop-X1>
References: <20231229131931.3961150-1-yujie.liu@intel.com>
 <ZZFbxyQeHgf3UQrN@debian>
 <ZZOkfPgs6T3ujpJo@yujie-X299>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZOkfPgs6T3ujpJo@yujie-X299>

On Tue, Jan 02, 2024 at 01:51:56PM +0800, Yujie Liu wrote:
> > Looks like it'd be simpler to just replace the "source" commands with
> > "." and leave the shebang as is (unless there are other bash-specific
> > constructs in these scripts of course).
> > 
> > Generally speaking, I think we should avoid madating a specific shell,
> > unless that really simplifies the test script (which is not the case
> > here).
> 
> Hi Guillaume,
> 
> Thanks for the comments. As this is related with a large patch series from
> Hangbin, and other scripts use "source" during the conversion, so we may
> need some input from Hangbin.
> 
> Hi Hangbin,
> 
> Could you please share your comments on this? Would you like to replace
> "source" with "." for these two specific scripts as Guillaume suggested,
> or change the shebang from "sh" to "bash"?

Both works for me :)

Thanks
Hangbin

