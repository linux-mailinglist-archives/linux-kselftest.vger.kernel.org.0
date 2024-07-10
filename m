Return-Path: <linux-kselftest+bounces-13491-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D387D92D81C
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 20:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8932D1F22347
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 18:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843B9195F0D;
	Wed, 10 Jul 2024 18:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OYRY4G6C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7F3195B28
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Jul 2024 18:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720635227; cv=none; b=UUEH5mzecliBMlbY5V9I8NPSO0ZNdiky/gnoSzRK1aTL/iIg3s+4zoVi9m4eI6WM6PbcmMZ2wA/LNGGeamIIOqJqDOJ7CvuOWJX5TJm6ptQMw+sUeHDTwT+S/Z33BQ7MA5u6RmQ0CifxnsiaewKU/axaJMzlnQJgwVX2YDgA8kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720635227; c=relaxed/simple;
	bh=WnP8NjFZqRnY3ckp7hvIZ9c7uXBIIep9VRnAPht+suI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l5bv5/eK6rfpo9+adYepJRPKhUiU6z8xI4SLz+ul7crnxDMP53Bj9DT6505WlQotx0z5JaZteV1wEHqBldRqUCwqLHGs6QhN8y0kDh8XX3MvEgky8YSyWQUnq1l5Nr2ozL7U6Pux0qnUteyWMvIDhgk07Rd5Ia1kwAleQ+V2IaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OYRY4G6C; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-38252b3a90eso47315ab.0
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Jul 2024 11:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720635225; x=1721240025; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u8uijbBytcudvJqY6fF3F/jCDvENgheJnf5tcdShyHY=;
        b=OYRY4G6C+ksr1ZhP1PQiL6oiuu5Cj7I4N7khDrwrKWunlYdxibYillgQEUqwZ2yEfw
         iHxt5GtkjBuhgEQT5ESevvynVtQaQT6tubuJeJl5LF8VBRoa5r6qvrkzjfovQZElJbci
         +7/px1YU0PE9qZPM2m0Q60KjXxeAPTNgYALCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720635225; x=1721240025;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u8uijbBytcudvJqY6fF3F/jCDvENgheJnf5tcdShyHY=;
        b=QTtPN/ajxd2/85nV460Nga3fLQyDqJxiVYq6T1n5AJyJkFF66Kz1tG/jBTSOyiDL2m
         SpV707U/09lb1BpuJyvkV8+fOFMgTamn8AS1kMUZ7A8vdYQRcGJybyU54LC8BClsFmNe
         X3OCXHx4OjKkqgFp6vELjWR1P/sQ0CbhdD4hFlMcSDit+ihvEpvgJrPA/qfPMD5QNeGg
         wfBO1CZS0tyrk+ZVEIY5ceC9uHfAT6ZT50gmQgCDfl4qx3hwTcDW90rg/83KA68Fi/zt
         d/Vn333eXiy03yf1HSriAOapOh0vfiZguGD4wQAy3oN+DIjUl93PqKJ5fSV169N5AkU7
         eHqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/v5Ifat8+fytgTP8IrdUDfwRYk6EZilZ0oixN6alxknNMOdjqUL4raIFdNOWVhgl6B/4mnK9sym4DZ+g3ByHs2oGJWs0ZPiIfyeaT3o76
X-Gm-Message-State: AOJu0Yx7esAO9AMPQGRiHI6no+FNYOsaIfaTfujHRrmAxnwXps1tcRLt
	fHvFsJx8A4FM9t9zojP2bhGtOiKKyvTai+GWznrti6/0BzcK0sxnHeB6Cao/Dlo=
X-Google-Smtp-Source: AGHT+IGMoshF5vRMxa/Dmk2GEW+wz4fPxzyZyUJu8bLsaeVkbb953Y0SWMesS1zsppJ+Atsrpe4udA==
X-Received: by 2002:a5e:da41:0:b0:803:f97f:59e1 with SMTP id ca18e2360f4ac-806d91a2a7emr38457839f.0.1720635224763;
        Wed, 10 Jul 2024 11:13:44 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c0b1c138c1sm1285856173.146.2024.07.10.11.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 11:13:44 -0700 (PDT)
Message-ID: <b9ce374a-8c95-4efe-a4bc-e9817defdbec@linuxfoundation.org>
Date: Wed, 10 Jul 2024 12:13:42 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: firmware: conform test to TAP
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kees Cook <keescook@chromium.org>
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240520163759.1427653-1-usama.anjum@collabora.com>
 <f7d8502e-21b8-43f9-ad81-dbbe07df5300@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <f7d8502e-21b8-43f9-ad81-dbbe07df5300@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/1/24 02:33, Muhammad Usama Anjum wrote:
> Adding missing maintainer and reviser.
> 
> On 5/20/24 9:37 PM, Muhammad Usama Anjum wrote:
>> Conform the layout, informational and status messages to TAP. No
>> functional change is intended other than the layout of output messages.
>> Without using TAP messages, the passed/failed/skip test names cannot be
>> found. This is a prepartory patch, more patches will be sent to comform
>> the test completely.

For these kinds of patches, I would like to see the output before and
after and justification on what these changes are necessary since there
are wrappers that add summary tap messages.

Sprinkling ktap messages in tests can make the output hard to read

thanks,
-- Shuah

