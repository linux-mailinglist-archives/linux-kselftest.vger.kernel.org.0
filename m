Return-Path: <linux-kselftest+bounces-3915-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AA8844FA6
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 04:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C8AB282455
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 03:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54B53A8C2;
	Thu,  1 Feb 2024 03:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTNkcnsD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3661C2119;
	Thu,  1 Feb 2024 03:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706758041; cv=none; b=HN6XlXlaJrGneE+aSe/ju6X+5EeownvCH/FQI6jaOpt0ytF2NtYo+YtaKDnAfyAH0jaJUC4JYEkiMtu4IgGPGWofr7PreUW/fxaO0Xd+sqonmpvktE7L//SZzYuzpC1fZIy9Oh6T+v5rMxyFguvNo2C4j3BXQUEoyLwtEBQ4t9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706758041; c=relaxed/simple;
	bh=ejPuBjH+Meun1WpT8qRRnvEgK1DbqRgZjIZrVQYBjEs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D9WmtzpfKSmfIcHb92v8RpI6dKAXIFDFjGaH+7SZXs44rkmjyJpBmLPQGNzJmxo+5er8ZpSnGKMlj3zBxp7RA038LkVKGxlhUj6HESAGpPY6BHLJUKbHmZSaR4ER5ViqoF6eZbOie/cI/IPmE5UYTe08V71k7/sclNGRIqlEqbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTNkcnsD; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-42a9f4935a6so12596591cf.1;
        Wed, 31 Jan 2024 19:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706758039; x=1707362839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ml7lE/7jOU9DhBBfBhymR3i9jaBtoqE5+xDv3Ffc69o=;
        b=NTNkcnsD/sTqfc096H6qvRCBfeN/Ee5Uj1GlgbELxXAar96iFjmaU0oMm+XHPZq/73
         e65NHKLFgt4vcMczrj3vds5b9KyggLSbhHSrViwZg8U7iM9Ge9KJApweXvwYx8Q3H/FH
         9Rw33Jqxuq/bxKE4B3G0hXLKLgUXMGGHPbelN3gucDTnDvF0GGT09XgJ+Bkr7uQGgtfa
         J7bjnUi3QaJAQid5+iV5CHE6tTlGE0XajbBmF81lfnBX4J6NlZhiBHpmvgQENAaAbKXG
         sJ7p8QNii+EopCGxLu98MzOKudbsT0BbKc9Dkxa89MktBoUkKmrFqAXkWhruNuEU20hp
         7npQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706758039; x=1707362839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ml7lE/7jOU9DhBBfBhymR3i9jaBtoqE5+xDv3Ffc69o=;
        b=G1EmIclvWw7R6q9U/MaqMbHhajPFxw2ggMQvzctx4TWD7ciy3snqA8SongDDg9ZyBD
         CtURwWPQ67dfrlfoF7bd6eV3moVG1fLsIC+v6Zk64tQnLGkjJx9xL0YJ8vaU5069+7R1
         rduWrpstESk8Ys2ePBx5901KqS+WVTIx/XldIzD1SOQsNruCxxdVCgLkfNP4YP5XxZsI
         cPqBjVJoUs113sCEzHtPLJC0TA9gwipEj6gqXul8A7BetF2hs3aW7oGfB8EoMb28vPji
         twx7jrBJGBiRRPcxdZ3inFObSBAEFh0BDav2KGPbg4+XaFmr2cjbT7BDS6gHd8MkOLE4
         4Dbw==
X-Gm-Message-State: AOJu0Ywi+PX9NEGWgGlldqFFX0houBwPYpp647S8hbtItQn8rt8FYKHG
	nGTWfCjr47E6298lyVMG3qowIZ/O43maKaGTf4UUh+65Dz05qHKN
X-Google-Smtp-Source: AGHT+IEj9kMOOz+9SCiW2EFu9sHCzGgG9Bm0j5cHeHsr2RTAMIxEm31fZoadkKxBZYvSGCiyk91YUA==
X-Received: by 2002:ac8:5b8e:0:b0:42a:b06e:84db with SMTP id a14-20020ac85b8e000000b0042ab06e84dbmr4152150qta.12.1706758038978;
        Wed, 31 Jan 2024 19:27:18 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVpTlPL6phPPb+F7RFeSGIoQuPnkjXlvQfb8HqNdJ4jYPm8PVJUa5m61jo4k8SE//F5PoXQ9pjMADDhOYjImRj7nPzH6C+CP/IZlAXFJErzvq9Cn4P9AJnw9bJrQLV+5hPiGvzPi8hIzSn2jw4uMdlpiLcZprTyFgza/bHExC9KacugdVAr2VgE9Jr8syfRmjKd+sQbYHjGkQqbk9EyBLNLUO6wJdXslBVnwylTsXzqERmmlhXtFReTgf9H/LotUrDhimvCmWTOApBUNkdoZ4gX9KpIXYPZm1s1rItuELqRfqGSLs/8Uo0ANL3ejopexusS8dJ0gLbMPeNP3iMtrdh5TX2dWG5kx90G4cQ79KdTGXf/ck0K
Received: from localhost (fwdproxy-nao-001.fbsv.net. [2a03:2880:23ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id eh10-20020a05622a578a00b0042a40e3ca9fsm3941273qtb.85.2024.01.31.19.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 19:27:18 -0800 (PST)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: riel@surriel.com,
	shuah@kernel.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	tj@kernel.org,
	lizefan.x@bytedance.com,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 0/3] fix and extend zswap kselftests
Date: Wed, 31 Jan 2024 19:27:15 -0800
Message-Id: <20240201032718.1968208-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changelog:
v2:
	* Make the swapin test also checks for zswap usage (patch 3)
	  (suggested by Yosry Ahmed)
	* Some test simplifications/cleanups (patch 3)
	  (suggested by Yosry Ahmed).

Fix a broken zswap kselftest due to cgroup zswap writeback counter
renaming, and add 2 zswap kselftests, one to cover the (z)swapin case,
and another to check that no zswapping happens when the cgroup limit is
0.

Also, add the zswap kselftest file to zswap maintainer entry so that
get_maintainers script can find zswap maintainers.

Nhat Pham (3):
  selftests: zswap: add zswap selftest file to zswap maintainer entry
  selftests: fix the zswap invasive shrink test
  selftests: add zswapin and no zswap tests

 MAINTAINERS                                 |  1 +
 tools/testing/selftests/cgroup/test_zswap.c | 99 ++++++++++++++++++++-
 2 files changed, 99 insertions(+), 1 deletion(-)


base-commit: 3a92c45e4ba694381c46994f3fde0d8544a2088b
-- 
2.39.3

