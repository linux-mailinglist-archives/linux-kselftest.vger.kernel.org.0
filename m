Return-Path: <linux-kselftest+bounces-5521-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8486186AB5A
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 10:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10CBB1F2532C
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 09:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8644732C92;
	Wed, 28 Feb 2024 09:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="TFno7vEA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15AC36AFF
	for <linux-kselftest@vger.kernel.org>; Wed, 28 Feb 2024 09:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709112772; cv=none; b=X/7JGCMjLY3yBT9DqhfzTfLxzT7Ibs18CZQI38pINYtqXXUzgb+Oo0NyqsxOubCuRHm66watAeIXMUtAlTLKhryy60R6DaObLlh5FHL67HlfdWPWYryOFjKclqE17xaPkKGzDYiaCGqQ6kAMn0WHITn5nogYJnSOqO27UAQbt4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709112772; c=relaxed/simple;
	bh=uFslmsiSq1HBTE5LNPd44uZu/F0twT8BTQkMgaIxbMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mzSgX58fTsv3VjqQpHCutOaYTPlNJO9aUxBfwwJU2ohL4Yzi8b8a6Fr02c6vwai593UhUi7fIHDoUsv8Uq3O8Cpp7y2MpbLVUwMhsQXGZHfnm/U4z9GznkZLYmtsMyasC3CSzsui8vG/LTLxZMVtA5YmzgGO8+0XNT9mK2SLuIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=TFno7vEA; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33d6f1f17e5so3562898f8f.3
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Feb 2024 01:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709112768; x=1709717568; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mQNKJ78MfZyuiu4j+k295fZB+jgGmMFXgbaeQC8Zu04=;
        b=TFno7vEAtJvk8A1beRQwOvIZw3g/vzS8dk6zRjuy336HMS4eFvMMasQGb3bHpFZ+d9
         xzmRK/vLGm1lF86v1HAm0L7DioQbgSJKN7JEbS2AMj+eZGvo6NNOzEDpyah4lSzl9xzJ
         AYLV+Bmnj8I+Yn76qIgwQdsCL/iHrBrpP13cGK/GGMscP8JgtalnRHulvoW6R0K4/Bfz
         E5k195u0KWrxOrwJLNOzjqCio/SaEumX5jSlPG5+Ur74FogDy/178a6ei5dy/Ck4555f
         zLByFZF3soq+ophlRxY5yvvEEHCqyq/de/3rpbIUOWiUHw3kcZ5xbkaQ0EpdfwheQj8P
         UtCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709112768; x=1709717568;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mQNKJ78MfZyuiu4j+k295fZB+jgGmMFXgbaeQC8Zu04=;
        b=TPJrrAnRTj7DhxCwDy+IlRvwvJ9xA+88T7YumceUxRPRHkkjAFzp6dyiM3EEckrUlB
         mNC5BE3Uhf0TsXlJnYpMRByIk7EipRP08HRkqd4/cx2AcR73KihIGTUgi5/NI7iZlfD4
         RxomNmdYvF0NzwmgqgD0yzDJUzPpJFVNJEW3+p9Hd4fGqq1kyraM1Hl+ajwoxJkvtXC0
         mJCTqz3LFlHZ31KEuOgPBv5a7YhYZ755ThJ5Ti3gm0hUKgvg2ru5Rc579z4I/DQ+Ii6g
         H0u0iTt3CwRBKNm1EMXxPYTRVHrc5xpgnvWvy9UWmQtPDXg75aRoD49+FIC0x+XE6Xi/
         2iMg==
X-Forwarded-Encrypted: i=1; AJvYcCXyUY32mHUNwc6mRsIDzUb4rF10a/YKrpyLzo4w2t3FQbsdzwquY+numIl+Po0+/Q9N9RknOqYLrRmgwP6z5o9uE91s8FpeATvB4X2ZvEF8
X-Gm-Message-State: AOJu0Yxw+BJyaY93/VdkBtviuLJiU139orHgbB6hVzjrHu7Ok9l5Ey1Y
	LFpximVv2dzkIeAzlcGu4Xb1O6wF391NERRu39GDUsJK1zV00As2gKwzzmrFsxUIuDZe1H7oC9T
	C
X-Google-Smtp-Source: AGHT+IEWEqNQ9d2tqbJP6sC861PImJRIY/oH0R9V9AxQfO/Gs6YqWMFo4jl9jdQrcYf5WDRE4XxY0A==
X-Received: by 2002:a5d:4046:0:b0:33d:8cc0:4827 with SMTP id w6-20020a5d4046000000b0033d8cc04827mr8411713wrp.45.1709112767852;
        Wed, 28 Feb 2024 01:32:47 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id az14-20020adfe18e000000b0033d2541b3e1sm14587268wrb.72.2024.02.28.01.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 01:32:47 -0800 (PST)
Date: Wed, 28 Feb 2024 10:32:44 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: prabhav kumar <pvkumar5749404@gmail.com>
Cc: shuah@kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	petrm@nvidia.com, idosch@nvidia.com
Subject: Re: [PATCH net-next] selftests: net: Correct couple of spelling
 mistakes
Message-ID: <Zd79vEsSp7wlJWQy@nanopsycho>
References: <20240227175513.8703-1-pvkumar5749404@gmail.com>
 <Zd7lqr8Cz4XrNoI8@nanopsycho>
 <CAH8oh8U1KLxY95DQW9duU30VC5hdQd1YKs+8USuuz0k4JWtBSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH8oh8U1KLxY95DQW9duU30VC5hdQd1YKs+8USuuz0k4JWtBSQ@mail.gmail.com>

Prabhav, I'm not sure what you are trying to do, but you have to
re-submit the patch, preferably using git-send-email or another email
client you use.


Wed, Feb 28, 2024 at 09:42:01AM CET, pvkumar5749404@gmail.com wrote:
>On Wed, Feb 28, 2024 at 1:20 PM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Please fix the patch subject to include appropriate prefixes and
>> rephrase a bit like this:
>>
>> Subject: [PATCH net-next] selftests: net: Correct couple of spelling mistakes
>>
>> pw-bot: cr
>>
>>
>> Tue, Feb 27, 2024 at 06:55:13PM CET, pvkumar5749404@gmail.com wrote:
>> >Changes :
>> >       - "excercise" is corrected to "exercise" in drivers/net/mlxsw/spectrum-2/tc_flower.sh
>> >       - "mutliple" is corrected to "multiple" in drivers/net/netdevsim/ethtool-fec.sh
>> >
>> >Signed-off-by: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
>> >---
>> > .../testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh | 2 +-
>> > tools/testing/selftests/drivers/net/netdevsim/ethtool-fec.sh    | 2 +-
>> > 2 files changed, 2 insertions(+), 2 deletions(-)
>> >
>> >diff --git a/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh b/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh
>> >index 616d3581419c..31252bc8775e 100755
>> >--- a/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh
>> >+++ b/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh
>> >@@ -869,7 +869,7 @@ bloom_simple_test()
>> > bloom_complex_test()
>> > {
>> >       # Bloom filter index computation is affected from region ID, eRP
>> >-      # ID and from the region key size. In order to excercise those parts
>> >+      # ID and from the region key size. In order to exercise those parts
>> >       # of the Bloom filter code, use a series of regions, each with a
>> >       # different key size and send packet that should hit all of them.
>> >       local index
>> >diff --git a/tools/testing/selftests/drivers/net/netdevsim/ethtool-fec.sh b/tools/testing/selftests/drivers/net/netdevsim/ethtool-fec.sh
>> >index 7d7829f57550..6c52ce1b0450 100755
>> >--- a/tools/testing/selftests/drivers/net/netdevsim/ethtool-fec.sh
>> >+++ b/tools/testing/selftests/drivers/net/netdevsim/ethtool-fec.sh
>> >@@ -49,7 +49,7 @@ for o in llrs rs; do
>> > Active FEC encoding: ${o^^}"
>> > done
>> >
>> >-# Test mutliple bits
>> >+# Test multiple bits
>> > $ETHTOOL --set-fec $NSIM_NETDEV encoding rs llrs
>> > check $?
>> > s=$($ETHTOOL --show-fec $NSIM_NETDEV | tail -2)
>> >--
>> >2.34.1
>> >
>> >

