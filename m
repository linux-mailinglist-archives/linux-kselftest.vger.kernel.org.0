Return-Path: <linux-kselftest+bounces-13997-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF4193933B
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jul 2024 19:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F0761C20E7D
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jul 2024 17:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F7A16E864;
	Mon, 22 Jul 2024 17:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G2iDSwe9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4961401B
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Jul 2024 17:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721669559; cv=none; b=Zxyr8vdaAjtGD/RIg4yol41hqmvigDWmHWRz4BaUanvHHmkOv467TgX/yQbPBOuSlx9W32fbdgW5kYq5/v9UdY4L/5a1V8JyKATa5RcLjR+nr1IZRnFxvRdQMidCdJOTWAs9jrrg5BnflyCoSPiubq96OinFetmIWef3TotdZR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721669559; c=relaxed/simple;
	bh=YCbBVPoRujTuH/IzgyukSKeM2NatIxPQihrHU3dth28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RnMNMwH5E2CK2OOLtZYOa0GgQOcuFt4BC74TzrZ1+6UDmnuk3kXVFz4amYDsLja+E+0HSXbSxgfv4R/j6TAHeL2hl8U+mOFfPuEVvp+wyr6xG6/RRJ7Y6MYG7sn1NxG6DLkgwQUpsevpMQuSc3+o4VtbqvM24uElmKxcH92dK9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G2iDSwe9; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2cd16900ec5so187488a91.3
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Jul 2024 10:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721669557; x=1722274357; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OKLoLrXld5zXnC2TPTdAAWRPh8tguM0xPjqljzcPI8c=;
        b=G2iDSwe9G1ARXc/lWQbtNNMp+65WCD0mucZy7aQchBd2cmic6wS5YXLs2wfdKxivHn
         ybtHuWWHOT2rIcoC62gwjJ8fY1oGFrDOK1Rc9Q4XKlFHOYDNa+ebMMgoWsKN64wcRlxn
         9K1srYrs4Ep7RR0ODvtUUV9d/acQ4orhwOzPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721669557; x=1722274357;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OKLoLrXld5zXnC2TPTdAAWRPh8tguM0xPjqljzcPI8c=;
        b=SThsAveQOp4T17qtNSt71z98TL10PTdLtrn4EyOcBoZQ7uyrW6crXfJJPLEcsTXbM4
         4YtjRnNxoKSq/F7OeHnqbghLBAtkvCnwPt2rC69/x/6Z5cIVWf/8SLq+As3YwCWoGhvV
         QnQH3/jBTqBJZemAN0hnGkHkUqjnJG81kOk/Z1g6QCvSUI+M9Q6W8pAaCMruv4/iCQVO
         JTyJaA2g6a0lfnKw9YOxOpv/9sVGwm95GATWk5D1BBOMfRienXW+iBOAxB7GRgeN2Xeg
         kae2zODZPK6JfQRKBQn27pdPp1m0RBVDNWfXZ/RwqtFobJZ10MZK9Ww90GD+7Nl/HLAF
         8KLw==
X-Forwarded-Encrypted: i=1; AJvYcCVtqs5abMQ1zpbX5jEKsWp0nLBWEonVnVHj0JzJNUO04P0d3llqdctkN4KSNI0v36oxaEz+dDHAEDyutwrl6pdHOwL2/HiZ7acWAlEe/zJP
X-Gm-Message-State: AOJu0YwKHURgxSmuqPVV+P3CDySc4C14m+wRPukp06eEeQqydlfUpmzh
	CctwFDfXiSXl/kgv4nIaCnX6mDoOe/31KxxEakuQXjldtRGftQAzK+Kdl419Nso=
X-Google-Smtp-Source: AGHT+IECCFv46PbolkfKo+kIFuV5CZ3MQLZEEljYyHDsZgCM/hHd4/Oq4TnhT5ElcnZlWhyLVoS2WQ==
X-Received: by 2002:a17:902:f691:b0:1fd:a0b9:2be6 with SMTP id d9443c01a7336-1fda0b93152mr24604135ad.2.1721669557153;
        Mon, 22 Jul 2024 10:32:37 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f4530cbsm57316135ad.221.2024.07.22.10.32.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 10:32:36 -0700 (PDT)
Message-ID: <0fe1b57e-4557-4020-878a-7eec13a2fdb1@linuxfoundation.org>
Date: Mon, 22 Jul 2024 11:32:35 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: ksft: Track skipped tests when finishing the
 test suite
To: Laura Nao <laura.nao@collabora.com>, shuah@kernel.org
Cc: gregkh@linuxfoundation.org, nfraprado@collabora.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20240722154319.619944-1-laura.nao@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240722154319.619944-1-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/22/24 09:43, Laura Nao wrote:
> Consider skipped tests in addition to passed tests when evaluating the
> overall result of the test suite in the finished() helper.
> 
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---
>   tools/testing/selftests/kselftest/ksft.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kselftest/ksft.py b/tools/testing/selftests/kselftest/ksft.py
> index cd89fb2bc10e..bf215790a89d 100644
> --- a/tools/testing/selftests/kselftest/ksft.py
> +++ b/tools/testing/selftests/kselftest/ksft.py
> @@ -70,7 +70,7 @@ def test_result(condition, description=""):
>   
>   
>   def finished():
> -    if ksft_cnt["pass"] == ksft_num_tests:
> +    if ksft_cnt["pass"] + ksft_cnt["skip"] == ksft_num_tests:

Please don't. Counting skips in pass or fail isn't accurate
reporting. skips need to be reported as skips.

thanks,
-- Shuah

