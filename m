Return-Path: <linux-kselftest+bounces-33922-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FDAAC6428
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 10:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 998B44E0DD8
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 08:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C83267AFA;
	Wed, 28 May 2025 08:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JxaZQzB2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60901F63F9
	for <linux-kselftest@vger.kernel.org>; Wed, 28 May 2025 08:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748420042; cv=none; b=jgoWQY0hv+gEHVgeB7LEh7v/l03LR1GMNql0+gnXorhB9HOaMkbY5t40Pj9+bPuFejXmIXtw7Zbvxk6lKbiLYtO7Xo7kQ4b/hYwfvxPPTkr4d5kMJYjdPpAMqs61fh7NSTq9wcMZvGwiHUnYCm6MwxOKft9ClX8Sz50A7YG0BHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748420042; c=relaxed/simple;
	bh=/OifdVsw6OCr5BBnQwxfj/QTcm4ajzqmm1ir5d2TDLg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Qxc356wIWBECuOsrptBHapsgIZXF7UXG4PNz7qPvgRrCvRne3+3CUI/3T8AzT92vRrQUtnY/dhRaNHqku96LbJI8hWfcXQUChnX75QuhsqgCxDHrnABt3NMtL8QWPivF1+mWm6g6HLJuRrXO/1yLafmyrM1Ft5lr9lmBCnHgFyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JxaZQzB2; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-442f5b3c710so39156465e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 28 May 2025 01:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748420039; x=1749024839; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h3U9aVn6MyTnBxnrEUm+FRp5npsaQCpxjjbTUHKj2sE=;
        b=JxaZQzB2LbLbBABOb+5Nn3q5QzFfwMpllLlOb+UGW7PBmWg16d0t8mTjocnD+dSDpH
         ENyHpaf2FZQLtSV3YXtt9dLgB6BThbPN71IjBQPCimBOwLApppVp11UxpMd4PGndfQ0/
         QwBwQkB4PK+LXa0/w2QBXon0beQyFidfSMT5YypoloNB2xXdUWXIFT30FclxKyx4Ws5w
         DAfBOdMPGkBwd6mD+8MPeMEUa0vscREdmXIb9U59F+p2sI+dw3jTl2fHj9iRaBRhx7WK
         MF5rYO4hSb4lnjY5NzYH5sDIE42r8yktVRTNuavw5sednnNZ43cJ3L2Yu/8nWwvGZrrk
         vWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748420039; x=1749024839;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h3U9aVn6MyTnBxnrEUm+FRp5npsaQCpxjjbTUHKj2sE=;
        b=QNQxEpa7Z65UT+T9Kn7wAKv3w75mojv4lQThsfOj2iiVCOWSgbvzoKOB2VYsnPOqUf
         soyoQUsqNV+U9w0Kyu1i8sQmRuNn1qtJI2a70euwzb+3yp2fXkTzxgnHYaLrwHPhX8ku
         whMz7TmEbD6ZtM7+uomQkaErSmDJ13blGOuLx9QB3DZLZ4TgnceMiwfVAFMlZ444eDSN
         G54YMlRAMrNvdPtB0SqZwiEmFGepS/SW+N2AVylSTDgt4G+DXKPvzrIWlUTPNeU2t/i6
         n0BqTFVcBwj1u9PFVEdXkl5eBayjGeTsP2iJOAWolyl0qpMdYI/FF/1IO20ZLNWUiyzC
         jKHw==
X-Gm-Message-State: AOJu0Yx0B1VTE9xLrn6vvH9ReoNkm+6AGms2tM8bfjanP8ZoaVymhVVW
	OCAGrJwukj0lydRvGgj4oWXGED23iNKG6i/hnqKZ83BaPsT7+qNLfk41jPGOni1CcsSQoQt6kw7
	dY10w
X-Gm-Gg: ASbGncu3SqJKxkBQINzI6pspsEZXCVwRJMikCLqGetcm8B5I83RZX8FRG99i5pAdUip
	XXVVZIxphxl51/FghdIj8EAJcijFcu4lpnbtLEtXQtaJlYyx84yeqEoudBcinMaJGxr79a5/gh1
	wkXSLeAPQ32jFHwIZty5nexYZqlV3RuLtrU1Kp7BB6u9lhkQnRMTkQmD87X0DKNMj9nCcthiRmK
	awVU6Sx3M2aZJ0LRVOVC3GQXlnCjp4BYVyEiJrLH8BX/HoqEpVcEfLExi2GYqNG4sw05UpGYo/R
	K3rDp6+rn+DQjcjoouzchZ4UKawuF6+Ov61kFJA/1GBL4/cteRHtAvJI
X-Google-Smtp-Source: AGHT+IEnQQOm4Hqan+wYatLAwMi96+pvKO2PgMNdHDTPQ9Z7wRUnyGksXGWHZ2+1USXvwHv6kbdYhw==
X-Received: by 2002:a05:600c:1c87:b0:43d:b32:40aa with SMTP id 5b1f17b1804b1-44c91607358mr169506065e9.3.1748420039167;
        Wed, 28 May 2025 01:13:59 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-450064a1ba1sm13301875e9.16.2025.05.28.01.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 01:13:58 -0700 (PDT)
Date: Wed, 28 May 2025 11:13:55 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: linux-kselftest@vger.kernel.org
Subject: [bug report] selftests/landlock: Add tests for audit flags and
 domain IDs
Message-ID: <aDbFwyZ_fM-IO7sC@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello Mickaël Salaün,

Commit 6a500b22971c ("selftests/landlock: Add tests for audit flags
and domain IDs") from Mar 20, 2025 (linux-next), leads to the
following Smatch static checker warning:

	tools/testing/selftests/landlock/audit.h:408 audit_init_filter_exe()
	warn: unsigned 'filter->exe_len' is never less than zero.

tools/testing/selftests/landlock/audit.h
    399 static int audit_init_filter_exe(struct audit_filter *filter, const char *path)
    400 {
    401         char *absolute_path = NULL;
    402 
    403         /* It is assume that there is not already filtering rules. */
    404         filter->record_type = AUDIT_EXE;
    405         if (!path) {
    406                 filter->exe_len = readlink("/proc/self/exe", filter->exe,
    407                                            sizeof(filter->exe) - 1);
--> 408                 if (filter->exe_len < 0)

size_t can't be negative.

    409                         return -errno;
    410 
    411                 return 0;
    412         }
    413 
    414         absolute_path = realpath(path, NULL);
    415         if (!absolute_path)
    416                 return -errno;
    417 
    418         /* No need for the terminating NULL byte. */
    419         filter->exe_len = strlen(absolute_path);
    420         if (filter->exe_len > sizeof(filter->exe))
    421                 return -E2BIG;
    422 
    423         memcpy(filter->exe, absolute_path, filter->exe_len);
    424         free(absolute_path);
    425         return 0;
    426 }

regards,
dan carpenter

