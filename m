Return-Path: <linux-kselftest+bounces-33757-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 182BDAC365C
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 May 2025 21:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B4AD1737CE
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 May 2025 19:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5B31F4289;
	Sun, 25 May 2025 19:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4mDhzF4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4AC43146;
	Sun, 25 May 2025 19:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748200767; cv=none; b=lEMVlLuakcTNFzQfGrTR2LTO1tV3nwKmqzv04lkhUXVMwCJGK0C3c1I8uP1B8j5XgXTvOy486DP2aiD+w6TQj2WQQNBZqqQUbtR0LXBarl30riHgfOkgMIIsf6L8w7JbSMgiPoeJh1/z/mlirWn/LBlvRgmxw+5Natgn7FzaUyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748200767; c=relaxed/simple;
	bh=uCbl56zTvR5oX3QuUueBzYZCm+S64yobnDZB90prxRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G4kzKRwQcpC7if9LdQ2XTYiuswd8i3W0kOTR18b8jG0ys2ifeFlpqsshOoVJ6YMVX8bIJ+F5xLHtwuB5GSBfy2x1cuWR4cLSIwqRkw8MY/dHEIv7nVhBO17ieLZ6EgWYK6wSGvZeJ7bQS6qejPb2b0BqbhqcdHMnCRbbwNmAZ0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4mDhzF4; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b2c02e79d31so952781a12.2;
        Sun, 25 May 2025 12:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748200765; x=1748805565; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uCbl56zTvR5oX3QuUueBzYZCm+S64yobnDZB90prxRQ=;
        b=N4mDhzF4U9CbRYFEDfGSnz68ODW6xs++aKbmwtyT0CJu96LUDLnMCFldLKUBQkq+aS
         G2NCOZ9bVqTsGQqBjAdyyWJG+9CX7Vi6D5ffWXUSx0UQFWgctGGQY1sxWh58/gLGpkhF
         j9PZIVmuuIz0qrQrn9J6jUYmmoT7ZPCHRXlhGw78y3Zr8Gv3pg5+X4Oj2Goa6L+HW+AN
         9CbyqFif1ZcMAtuN4i+YPq7t2/kIoSDg06AEzQzpp9WNufrHcrhZRDxfrc+/ITHGiB72
         tpM7tFTLs0MzAO14WMkYGwRi/GZmEkyXtWNlNp+Ch7aeUJDRvu0oGI/T2JIUd6Sw4MBG
         GRbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748200765; x=1748805565;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uCbl56zTvR5oX3QuUueBzYZCm+S64yobnDZB90prxRQ=;
        b=MY/viP5vVxFtY4GUTx7w+GxajjrnXd6SRxXwgVcPxXEqpRB17Z2b8vmhHSq9kSjCiP
         uoYQUL4w4k2nHF5YAXbAs2nWUvwNm9Djhg2ghWV1o5x4qu1ai1tMyLtFv+J3wtmsgJTR
         35OK6dGI3VXcAFaK6I1oMNFCJXzgAVUBbSOmM8kFATYtB4EWqFx0OiT5Xc/HCyjAie7v
         gsq5XHqhomNjyoVJPFP57VRWWfkPU1091u55jj3P8EQTGlSj4ObvbG55w4p65GXIsypl
         pcUq1l5H33X2MLbJTSveEp5CeDfcl6eyo0PD7eXTeUbHcfbaJdoS6uv073GUJhaqLNST
         xD/w==
X-Forwarded-Encrypted: i=1; AJvYcCUOiJDIpn5tFmQFEdT2NUeS81m3A4Qv/EXrFofZ5qbzjsXOJoIF8zkbeelXy32JhTHUlGdx7jUqVuGfMk0=@vger.kernel.org, AJvYcCVmLv1b6L121bSAdsHuZZmBmYGmwG1lovq1HQOcrw3jrh4FnG8XmAZOEHfbtHWa74NbYtTZzb9q4XYgNKoCLpVs@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6dhrT50tT0WfU6QSbLdIDQOBGMSktQ39TBcVldhbmBqTeHxo2
	o6/v8t+e7asvT12FfSnGZhyJQC1J9by21CjFLFhmntQ2ycUAd0qkPocVGgY7PZnqRxMQI/usEDr
	MSqvXEY9N6NIkUj5M1pbH7247D7ulTQ==
X-Gm-Gg: ASbGncuzCASusK8EIMhuSmVEezKGiG+yXF9y6tKuJUqZvqS5gO0X4LVzj0nyeuYRwkT
	H1UeDRet28G+Ll5Un6P88TgJ82YcQlP35+5ShamJFmqCzANgja6RvKkiGGAqbIjIRjrUmF8vNKL
	0CsdS6wLPfXNzGw6RcCQOwa5GbhYfzOLLFH2giXusrqLsXzyfuJ0Y+3raDLKHZlmlAQ6ayDMz06
	nLJ
X-Google-Smtp-Source: AGHT+IE49QtSZD/cKBZ5BP1yA1DXZJqPWlGny04gQQGYYgaEAFtSE3U5Dq1FLXkagjEVnZI5VV/7Hij8OlK/mpvnwpA=
X-Received: by 2002:a17:90b:52c6:b0:305:5f25:59a5 with SMTP id
 98e67ed59e1d1-311108a4e7fmr9846167a91.35.1748200765413; Sun, 25 May 2025
 12:19:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501163827.2598-1-ujwal.kundur@gmail.com> <20250510160335.1898-1-ujwal.kundur@gmail.com>
 <D9V0UTL5BCLM.1WHR6F4UN14QQ@google.com> <CALkFLLLfxT1pQ_ySB1NU4KXOEGLd2wB8pbhpBG2HfK3_mLOYAQ@mail.gmail.com>
 <DA0VHZ6KE96B.XOYNEFMGWD58@google.com>
In-Reply-To: <DA0VHZ6KE96B.XOYNEFMGWD58@google.com>
From: Ujwal Kundur <ujwal.kundur@gmail.com>
Date: Mon, 26 May 2025 00:49:12 +0530
X-Gm-Features: AX0GCFuYwumGBCs4IZFi7ChmVZQtrJenzu_p2fgKD9W_iisr7rslKvFgB_F8ufA
Message-ID: <CALkFLLK19Uqr2veWCn79cbLLgde5f+otf9Qx0xSPGdhdnekGrw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] selftests/mm/uffd: Refactor non-composite global
 vars into struct
To: Brendan Jackman <jackmanb@google.com>
Cc: akpm@linux-foundation.org, peterx@redhat.com, shuah@kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Sounds like that's your issue - for the kernel, tab is supposed to be
> as wide as 8 spaces, not 4.

That fixed it, thanks! I've gone through the diff and made sure there
are no longer any inconsistent indents.

> I'm afraid I'm too ignorant of this code to be able to suggest something
> good here. But, can we just remove the comment and plumb the gopts
> through to uffd_poll_thread()->uffd_handle_page_fault()->__copy_page()?
>
> This is not pretty but it lets us remove the global vars which is
> clearly a step in the right direction.

Perhaps Andrew can weigh in? If I understood this correctly, we're
trying to assert that retrying a successful UFFDIO_COPY operation
always results in EEXIST. This is being done in a somewhat racy
fashion where a flag (test_uffdio_copy_eexist) is set every 10 seconds
using alarm(2). IMO this is a flaky test, we should either:
- remove this variable and associated logic entirely (preferred)
- use a probability function to set this a % of the time instead of
every 10 seconds
- use an async library that can replace the implementation without the
use of global vars

