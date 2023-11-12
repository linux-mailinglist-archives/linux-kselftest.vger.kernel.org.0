Return-Path: <linux-kselftest+bounces-35-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DE27E9241
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Nov 2023 20:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D82A280AB0
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Nov 2023 19:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D7C1548E;
	Sun, 12 Nov 2023 19:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnHLfiXF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C2D171B5;
	Sun, 12 Nov 2023 19:30:30 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E14E1BFF;
	Sun, 12 Nov 2023 11:30:29 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cc921a4632so33275985ad.1;
        Sun, 12 Nov 2023 11:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699817429; x=1700422229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WJm6Mh4+ZHA7/pgm2J2SRO41c+3M2W1YQNabxlej2Ko=;
        b=XnHLfiXFjLr0Oyrugdw69RUbMsjX8SNEFX+2hOFAFemmEfiTGKEfTv8nYFivLoFVYZ
         fLE1G5izjT++P1Q/VcTLEYlT2tDOCQ9N5afeiHf17BKbgOsT/CKrGNy4YeokUO0/LBz7
         2WWdvFAgJOcQMUc7Hs3A9BRY8Pacjd1xmT/q5qyGQP1+PRDwQWnvrsB9CIdB4h+kWHCr
         TFWyki2rn23PFLggIMP3M8xzEcRkAg+psdPvskn9ltNkumysBMK6EB0SgYd81efLoMsU
         0KQuJtZaAqNxXJ562S8wL3hMMdDT+M7otl9p8czzAXSGULcgEXe+QH4pTRb2X0AMAtVM
         Hg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699817429; x=1700422229;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WJm6Mh4+ZHA7/pgm2J2SRO41c+3M2W1YQNabxlej2Ko=;
        b=ellQC/FtgTOiCgdJFNeoSpegkKASDhO/WnrPGUJqrrow//6jDPqEys0O4N2BPWJQ83
         dkrTHID7M7tu8iZi+MwoegkZeetqkrjd6/c1SGWObt2cyrjUEb40Kx1Qcb9HSRrxwy7y
         6OCgjYaK8gZ4IClXJX6mLmCNy0YmFe7q8uVSvAw4Y8kQIsYspZPRJj5IJUBcfqoWiGFy
         grg8fWoVvokFTv/Kv2LVmMNpo0IKwXjdSF1kYytqLyClXbKxIP/SuTba+3iw+90LvK6k
         LgLEsZL7pPxlvS7ebboq2PiOmolTmSHjPx3F993RuJNEhLYVqQ4L4Szeu/Z0GmUUWSXn
         5N3w==
X-Gm-Message-State: AOJu0YzOYpdOEt68c0IKCNQE82iqkxiZV4+LXeVdctAGx9v9CLUlGqYU
	b8jpHu9QKl/rFIAg7Ey2KUM=
X-Google-Smtp-Source: AGHT+IGjlf4GCjYiCAytAvSrC1xIIYHFIic7/6VL+I+htAAQYcyctxIGn72mNbr/sfvOBKlfr3Wlzw==
X-Received: by 2002:a17:902:e80d:b0:1cc:4cf7:2cd with SMTP id u13-20020a170902e80d00b001cc4cf702cdmr6634578plg.33.1699817428590;
        Sun, 12 Nov 2023 11:30:28 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:7384])
        by smtp.gmail.com with ESMTPSA id z2-20020a170903018200b001b9e86e05b7sm2879745plg.0.2023.11.12.11.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 11:30:28 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Sun, 12 Nov 2023 09:30:26 -1000
From: Tejun Heo <tj@kernel.org>
To: Atul Kumar Pant <atulpant.linux@gmail.com>
Cc: lizefan.x@bytedance.com, hannes@cmpxchg.org, shuah@kernel.org,
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] selftests: cgroup: Fixes a typo in a comment
Message-ID: <ZVEn0jcGeFOQKhNW@slm.duckdns.org>
References: <20231106181034.117120-1-atulpant.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106181034.117120-1-atulpant.linux@gmail.com>

On Mon, Nov 06, 2023 at 11:40:34PM +0530, Atul Kumar Pant wrote:
> Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>

Applied to cgroup/for-6.8.

Thanks.

-- 
tejun

