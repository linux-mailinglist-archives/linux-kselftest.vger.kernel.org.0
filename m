Return-Path: <linux-kselftest+bounces-44814-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23757C36353
	for <lists+linux-kselftest@lfdr.de>; Wed, 05 Nov 2025 16:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C32A560EA4
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 14:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5190246335;
	Wed,  5 Nov 2025 14:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pw8CL4vh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CPTSRaBO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14417243956
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Nov 2025 14:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762354101; cv=none; b=SiHTJPJed+/+zqxqwydQTdT5iLmZFquBb6CoLi9XkvD+1Fm7HgbrGmqnVknZOXpPOTmIOR/d7zwFYWotujAC8zWJ3vjtSuJxNy8Yr9+eoI+/O7zFiEqT3X1lTaXMHcvg6jQ4LRbthoaSFhDTJdtIv61Fnf/C7/jmm6n1eXPgIEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762354101; c=relaxed/simple;
	bh=vSOblu1TYmytU32Afj1JpSAwMW78+1eufiWSTZpAYPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWj2/LTXu33NViwsjcoK0+WPg/UGTj1+ODrc0kzjKTYkbK+fgaGeDXCFomvKlLW5xYuAFeeQrtpcdUuttrhjyqBc3ODjax+MExd56A0R9+TLcpbgQx6nPSoxbt5PAyIkcMLp1FV0OL/TW7i4zbWNGyj2WdTN6TCCHWMoA67NQF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pw8CL4vh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CPTSRaBO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762354099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CALwuHsQmFBRZ9UMoQkNa65lCmf3uyfowmB88gX3QjM=;
	b=Pw8CL4vhxwOIhJi2rr3ghGz64ojXiPgNEeKbOKf7fWJSzPVuMxYy1B1azQoRiddGs3vc8p
	kCBIH+oqoXBV0BfaYK09E4tu4YoF1vINpKJkPxxqazk1Ki824FjD6NVmcBjJ0nBug7qNiJ
	17EO0EyDHN6hSIakVo1w99tKyvQuRSQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-A8xlGI3oOd-o_m7mA2Dteg-1; Wed, 05 Nov 2025 09:48:17 -0500
X-MC-Unique: A8xlGI3oOd-o_m7mA2Dteg-1
X-Mimecast-MFC-AGG-ID: A8xlGI3oOd-o_m7mA2Dteg_1762354097
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-40cfb98eddbso729029f8f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Nov 2025 06:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762354096; x=1762958896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CALwuHsQmFBRZ9UMoQkNa65lCmf3uyfowmB88gX3QjM=;
        b=CPTSRaBOc5j6ZUbN64DZl00ifkDoiAGDs/NpxASdsAUa9XdcHmTgcFEcbEP91yYAn1
         /LIdljHx+x5qWaXFNeK28KMeRaMMn5B5vbeAgvLJXPLC9yjcLkukvVQFjpB5GDiqAeAz
         Epac/ZvZb6C4uvEYY0YpIibb6eaC907mz767l9kUPRrjJkpd5enN+jk7Z5ket6njL41y
         JeTs8Q7IXOY5RIPMNgRIbffpe+ysRxBSljdhNiuUqixZYu4LbOlLLdunylT334arTF+9
         wZiQWVeAKQNvQSkeeqXJLhALWHx8IJv5ODd813wEVgOBfWJYBO/SQQedcIPA9MjPjgaq
         udMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762354096; x=1762958896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CALwuHsQmFBRZ9UMoQkNa65lCmf3uyfowmB88gX3QjM=;
        b=LOuIA9JGy9Or4mMFrUgI+QAIKnlldJygWRM2Mvqt2swuehEYvRgUoCKXfhi4c0t+Y5
         QoIRWrrRX1hz+IsM0pvcIHlbh+0KZ5Tkyq/DktMauwHN758BJgAK6hPd+NeXFCyKSt7w
         Y7NA6mpXML8YMkgmOdCAIAxhCSAEesdge6AzV5yWnCTo09mckrrRu6+JW68P8pdMBkXu
         JIA5XJ7L/zEu6FHVicfsT2T1iMSX38yQzZWffQoU78XreL4d7cmJxtUzSK4WJ8YZzsjv
         4CI1eFsdXWJyX8fpvHfPQh7vFP5WygoFCSElZqH6oGswIV31GgNurkEkkRJgEuaLiicB
         UB+g==
X-Forwarded-Encrypted: i=1; AJvYcCWIqJYXvrmUGq3SVL/Tr9TERAb8S2BUzc3FK8hVz1Xjf2LQa+F2cjxggpk8YG7qWlLqEvyCCpWZ5ry8gH8RI+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIJvrwNXqQwCWxXTlrdsLF86T+dkHC0zgJ34FnxiN30qWZtiMT
	juDtBxjNEHso8GgUiTrYKbj4rCY2Nl7O4ewh1aUXfR/ZgOJxEgHX8ClTEjXyPzTWzye52BQUL4y
	DJlwnuEeU2J/mLsqZr4qWisCd7o2xQOzsbqvl2My031GI8nivLxm/hEY5+mXz4kVzCYw+xQ==
X-Gm-Gg: ASbGncv+CTL3pkb3kefwe7aQp3mm48SVpD10hSgnvpQKrprQqsTUVC5ZFas9QDVpB5E
	WXIm+EqTp1yVs7GgMi6weuIEwVnmq7P/vHlM+Wel2TQz51QCa2LAmT2UjZaPlX898oOeLYDdqMm
	nQS1Q3tWXO0l0tVJZCaIzzshB9YJHSbJZRVqGyrNram/wSehm9S0mYsiKDt+d03tt9bbv1zNZdZ
	x4HAVihOW5o5QizOc6fl/tv3Ayg8YxtGZ6A7KvkxN89LCRBUfzDrCUAJBVGebrWcjxKqwK9O62d
	Y3L9kyOJ7zUKRA33NMKw+oEY8FmagfM/bsorW/WBF6DtWXjkZJgNThurnTTW5CLaWqwvVTUmlPY
	=
X-Received: by 2002:a05:6000:184e:b0:3ec:db87:ff53 with SMTP id ffacd0b85a97d-429e2d91fe1mr3951411f8f.12.1762354096638;
        Wed, 05 Nov 2025 06:48:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrOCNYKDLHdDqnsKK5PIOXbPko9O2ocFPx7Xxpk9jaY5/59QMJwT5e74pWkY0THQmdo2gCiQ==
X-Received: by 2002:a05:6000:184e:b0:3ec:db87:ff53 with SMTP id ffacd0b85a97d-429e2d91fe1mr3951385f8f.12.1762354096174;
        Wed, 05 Nov 2025 06:48:16 -0800 (PST)
Received: from sgarzare-redhat ([5.77.88.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc18efb3sm12092871f8f.3.2025.11.05.06.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 06:48:14 -0800 (PST)
Date: Wed, 5 Nov 2025 15:48:09 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v2 10/12] selftests/vsock: add 1.37 to tested
 virtme-ng versions
Message-ID: <csgl7tb7jxlmbkn5jqjoiraa4a5vatmd3t4fv4duue5ftukphy@tem4fwdinmti>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
 <20251104-vsock-selftests-fixes-and-improvements-v2-10-ca2070fd1601@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-10-ca2070fd1601@meta.com>

On Tue, Nov 04, 2025 at 02:39:00PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Testing with 1.37 shows all tests passing but emits the warning:
>
>warning: vng version 'virtme-ng 1.37' has not been tested and may not function properly.
>	The following versions have been tested: 1.33 1.36
>
>This patch adds 1.37 to the virtme-ng versions to get rid of the above
>warning.
>
>Reviewed-by: Simon Horman <horms@kernel.org>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> tools/testing/selftests/vsock/vmtest.sh | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

I'm just worried that the list will explode. Perhaps in the future we 
should just define the minimum version that we are sure we can support 
and the maximum that we have tested.

Stefano

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 3ba9a0dfdd01..0657973b5067 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -152,7 +152,7 @@ check_vng() {
> 	local version
> 	local ok
>
>-	tested_versions=("1.33" "1.36")
>+	tested_versions=("1.33" "1.36" "1.37")
> 	version="$(vng --version)"
>
> 	ok=0
>
>-- 
>2.47.3
>


