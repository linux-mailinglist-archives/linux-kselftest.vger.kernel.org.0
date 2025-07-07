Return-Path: <linux-kselftest+bounces-36731-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3506EAFBD76
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 23:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 695623BEAE6
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 21:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D816C26F461;
	Mon,  7 Jul 2025 21:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtjLlmNq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FF5194C96;
	Mon,  7 Jul 2025 21:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751923567; cv=none; b=gaZIimANPQbozNeD5I6E8VgMlAXbGRv/mVc22DZUVVngwqCO6+MFOTbbAJYP5nYnar07en5KEqLXHob2BlvUFy8Szhv1xNUmXGDpO6nIravptX6TtYWX7dxOtC54QsDKPYF4Jc+PNcBDg/3kOi4KqMkbgRdpSJNpUxZU/VsKpCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751923567; c=relaxed/simple;
	bh=+JTpunOdTtURSzuON291S4b9xZO9qRanbPz4zXJad7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ql1rmCeRd1OKeALsJ99guopeWiYPffgZ24VEP7HPNScUAVrYXuDSjwsq1AJpWI9TEm3mSATCFiKKVmq/TrQUqJ91fQlUJ8RSYEsg55Njwqwg2nJSzk+4HvQCfhFEDd3Sr3o38qmnR+RRSUsE4H0fFJcjNjixkchiZ9nldlc0cjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OtjLlmNq; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e73e9e18556so3412036276.0;
        Mon, 07 Jul 2025 14:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751923565; x=1752528365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SbbSL2gnYP1ZOYPT+NaWp7SxmNH2oSTM3KI/P52qhN4=;
        b=OtjLlmNq24z5Ux3LCvaUQgrc7hgSUlO2IOF7mcGJmbCI8NE7poOVPypKWQ8j4yQXPh
         z8uc/SGzj4ZYdLb/Of1ETl2ZLlRbFQW7eDdzPHLT+RCWAokNPOhY/rnbE7t1BoFYcFcK
         127fnAs2+hshz9xqJ97MMhwfWaTHmtZpkvUjYtwzmuxAIosFdYVPqmSx1E9tnZz82gyR
         4WcETKBCw6xH/16UKteZ1KaqzXlcjABIfx0U8yEfmftqRbf3E/gBIiQWN/DTEowuH30u
         qVsrtn8Po3hWV38j/m+rwUtkJwsI4ALYuq4CiZBN0JQ+wqBVfNlhZzfz9p5YyN2larD0
         SUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751923565; x=1752528365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SbbSL2gnYP1ZOYPT+NaWp7SxmNH2oSTM3KI/P52qhN4=;
        b=tU0B9N0bg3T6caQ5lYPklRaxWx5aeIvkY2YolQ0vNZ18gDt1cSjtqKN75+lrgS5UIJ
         YYtO3jlq10sUSOC0BPFg6c+iLzoqaoWLmltOeWkrdM0cZLxrWxU8h+zyhopRPYcc0JoJ
         K9kreVKQlgqfFBz/DoLal2zRxYVx91R3baSuUpG0mh+t26AFvNkJiEihQt3kNAst4hKD
         Wk0yFrjAri+evGolmH1Q2QJETBBYGXFsiwza9wazg9TMU1AwxCdmWK2HaWkJZwkab+Bt
         ErvYWQ3+OW8l02cZqtylEiOAZ+WYgUbuB3mkZj8u0st1NXRr4eTf0eL7TThtSghgmn8N
         sLig==
X-Forwarded-Encrypted: i=1; AJvYcCVMEGKMOoys6GDSO57wtYzlwQWjRPvVpgu+LgzTr5MOfdASPrG2nPAC5jmrjArQhwm9BxGd5YFyQfcCt5w=@vger.kernel.org, AJvYcCXqn9KGq6b4bap519SxedW+yedTSy2atUnL98q0Yv8OY9KeUZBWsCvOg90N1pPO3idUmThhzbSdSWjLiYW0wTTY@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf2pK/icmlJQev6fGil+jCP4jZoP6fnu48EATTMu5vwfGx21PI
	vsBOCx/RjNXO7DK3KluIeTamjJZIQ4ROwI04iCwLh8VkNfHkMJFcd+M4
X-Gm-Gg: ASbGncvOlKsRAawdS7MYIKF7yMWa9lmiG94VDvTsD30c8Q0fro23iEf6ew+v7HLoiyw
	uAuSLnWarroQmK0fronp5SpDTf7bfKjeVjNdgwES2DpO74tG+5M3t4fKEUUSJutdtN+NgQeTzgX
	I6kpo/6MFP2b2s6NpjaFAjyMsPL65ipYv2akzCBtyZs4RlutFVmTbkmVHgA2WIr3YARsPUhQqZp
	RWkcoLNtRQ6SqUXBoT6LZR9tqhi4DoTxMgqj/dfXDu34Uo+hNWUxdIkHHvxjISkIRdFsNm0S35l
	bHOjmKbLEWCVwt3sZF3mhXGCNndKIhOi37H8eohHWOcUtlqYciEFpCWNPvQtIQ==
X-Google-Smtp-Source: AGHT+IE1rRBv9SKsXDVizGCcX/MQw3UTZ5ltGVPismkBhKYtdERManKJQ/zdQSzimtEoGONGeK3DIw==
X-Received: by 2002:a05:6902:c06:b0:e82:3cdb:7e9e with SMTP id 3f1490d57ef6-e8b62a13970mr319297276.3.1751923564967;
        Mon, 07 Jul 2025 14:26:04 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:54::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e899c4b782dsm2890852276.57.2025.07.07.14.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 14:26:04 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Suresh K C <suresh.k.chandrappa@gmail.com>
Cc: nphamcs@gmail.com,
	hannes@cmpxchg.org,
	joshua.hahnjy@gmail.com,
	shuah@kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] selftests: cachestat: add tests for mmap
Date: Mon,  7 Jul 2025 14:26:02 -0700
Message-ID: <20250707212603.992104-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250707152557.49877-1-suresh.k.chandrappa@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon,  7 Jul 2025 20:55:56 +0530 Suresh K C <suresh.k.chandrappa@gmail.com> wrote:

> From: Suresh K C <suresh.k.chandrappa@gmail.com>
> 
> Add a test case to verify cachestat behavior with memory-mapped files
> using mmap(). This ensures that pages accessed via mmap are correctly
> accounted for in the page cache.
> 
> Tested on x86_64 with default kernel config

Hey Suresh,

Thanks for the second version with the updates, sorry that I missed the
first time you sent this patch.

[...snip...]

>  	if (fd < 0) {
> -		ksft_print_msg("Unable to create shmem file.\n");
> +		ksft_print_msg("Unable to create file.\n");

NIT: I saw that you change this in the second part of the patch. However, why
not just include it in this patch? I feel that it would be good practice
to keep the kerenl in a "correct" state, even in between patches belonging
to the same series. If someone were to just apply this patch but not the
next (however unlikely that is), then they will not see the description of
what file type they failed to create. Just my 2c, no need to change this if
you don't think this is important.

[...snip...]

> +	if (type == FILE_MMAP){
> +		char *map = mmap(NULL, filesize, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> +		if (map == MAP_FAILED) {
> +			ksft_print_msg("mmap failed.\n");
> +			ret = false;
> +			goto close_fd;
> +		}
> +		for (int i = 0; i < filesize; i++) {
> +			map[i] = 'A';
> +		}
> +		map[filesize - 1] = 'X';

NIT: Likewise, I don't know if there is a good reason to include this, only to
remove it in the second patch. Perhaps it would be best to just remove it
in this patch, so you don't have to delete it later?

Please let me know what you think. Have a great day!
Joshua

Sent using hkml (https://github.com/sjp38/hackermail)

