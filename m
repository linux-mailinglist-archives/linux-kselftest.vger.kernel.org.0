Return-Path: <linux-kselftest+bounces-39189-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6292DB299DD
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 08:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADE55205A74
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 06:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DC4275B02;
	Mon, 18 Aug 2025 06:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgkpnL6G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A367D275878
	for <linux-kselftest@vger.kernel.org>; Mon, 18 Aug 2025 06:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755499231; cv=none; b=qm7kGA0T6xJH28/HG0FQPiaqhUZjb+m8cm0pVnAdxLeAgl6aqIx2hzQI7ILN1SLx53ezpeVaKQPFP55UMZHoO8i+CPHfp+4kIy4CXDeYQEoUMk8ZUIRmypV6BOmQvPCT4WZhTUxhGtRnEZDDj/mSOt4yAuea48vA/+52ehQDOd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755499231; c=relaxed/simple;
	bh=t9l3iGT2moqPKCdatCZEonuLHNcA0o3xJeqCNK4h3Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8k/p9tXjAcfLlLPPFnST90ZB+ELm5lI7HvnOBhn6jieCfgNFs7+pEmWcF34tKNFnRwKUzfEVCAcsCu1evRuN42XiII2Gc+vu4uDe2te9chkjurl0vl+rRCQYol9RFFQ99jUg12FwD5745bExTRiDaOk+bjTzCsEUhZ5JwXVEc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mgkpnL6G; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45a1abf5466so20030385e9.0
        for <linux-kselftest@vger.kernel.org>; Sun, 17 Aug 2025 23:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755499228; x=1756104028; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHRhDwyRYUb4TwjG35dT0f5D0HO6DNzP9EjaeHo4uJU=;
        b=mgkpnL6GK4iZ75WZGOj2O4LeCaDsRvI/g9EpYT08+nm0lArGIpsgWt7L/kLfu7OXAF
         Yp9fx/FYq7iiG2vtb9CuCFY9noQN3ZRILbmLltdWhk3jPPAYzg1HwBqVFNvMk4fqEdj1
         osW9CBfFGAbBmPCp3fkch1BFmS0g7y3ynbT2iK2Rzl4kqvBvyxUGj/F7FhqhQv0f8ZTJ
         Ht5Yq1CuumhrHJR/UyFibE46abxc7X7Qre5lLuA+/NG5jPIudBC5cejK98Auup8RHaq6
         BI8R5uxjoGeBlp6PAoL28YYgw2SsPrib9TmE+J9q71KspukJDUwOB9CHMsKRnGUmR32v
         sSGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755499228; x=1756104028;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lHRhDwyRYUb4TwjG35dT0f5D0HO6DNzP9EjaeHo4uJU=;
        b=Thmz3aovDrUxM1pX78L1Ys5Iprxj4/FaoIRlQaC+TjISM+zl16deuhzHgbpUsncwaI
         2ByXXMnpov5v6eXsSCgomfavzKYl68vapFhnE5abOcBoQeRl3g1ue9Ifctp6H2Fuor2Q
         1YAFl7O1X73QTPrZiswr+9pqet1uSF4kanfnojtIIiNglAadZsB0It8Mw3OeiOa4xZ2c
         ulyfkQwB23l1YSA39AGg7/YQc8B2lwjptIK+8bAztM8bDUiNZbOfKDKCO9laDjFQkemv
         HuhCe6mLypQgMP7zlC/Xf+YtmlzXhroECxi032f/UHr+z7bPAkVxnj9A3RJbfFuwsLJ1
         7kGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEKVaB7N/jFWJS4Vn0Grbnns1bvIrfLYANTQ6U0v8YSjK39L+abg9+Mv/rr7DAVMPcRg/ErUTTxb0chAFU4H4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX08CgAHQJcKhnRuupjrf98pXNYrhTtam3jsGoSU6RfDdLKLdp
	VbNTXS1nsEjwbzPdZ1KJYdZQiQgBD+fQXVCSeNYcftKk8g31oXT0OrsI
X-Gm-Gg: ASbGnctYGjpx0nW0LCFjT9SkD/+CVk74QQMfKmXiF14ynKEjkvlLEgvy7UZYGZ3vTSc
	8GkkSZIAXJRe8CvdRN6owc79YPAkuCEMCGjR8YwkrtWjBJOLKiTgU2SYnn3U3ZQzpTHJu5/9mUS
	mPnxURPfbyGFDJecOkztI48BqEj7LMDmA/c6zVFjeqsUWFnjkjUblBMtuizYxv88IF6n4r8wE2e
	cjP5iqUiydrxJYMux5sXosHwjmD/MEsr9uknftPe4GBq5qrTXwx9FOgVB1SUJYab2gl1cYw1MfX
	ecblPPzkuPQ6Fl0huw9T9Xm68g06kfKRJOGD1NOYeMPn4MV8LMRg+sTwnvp2AjAzR6hxiKb19BI
	NVJfEZiJcEH7XO/x8JdEETg==
X-Google-Smtp-Source: AGHT+IEklZkqqlj4pQE9hTOJwLOePZQxvYuZZS+FbaGplVr6in8Lz8zXjA+Qpx8rRj/KHhz0zm7o2w==
X-Received: by 2002:a05:600c:c104:b0:43c:ed33:a500 with SMTP id 5b1f17b1804b1-45a1b819ca7mr81403645e9.10.1755499227703;
        Sun, 17 Aug 2025 23:40:27 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c790689sm166654115e9.28.2025.08.17.23.40.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Aug 2025 23:40:27 -0700 (PDT)
Date: Mon, 18 Aug 2025 06:40:26 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, david@redhat.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, riel@surriel.com, harry.yoo@oracle.com,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [Patch v3 0/2] assert rmap behaves as expected
Message-ID: <20250818064026.htixfallwid3cdf4@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250818022905.15428-1-richard.weiyang@gmail.com>
 <20250817200642.c3ca3c89832fd9e0cb5117f4@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250817200642.c3ca3c89832fd9e0cb5117f4@linux-foundation.org>
User-Agent: NeoMutt/20170113 (1.7.2)

On Sun, Aug 17, 2025 at 08:06:42PM -0700, Andrew Morton wrote:
>On Mon, 18 Aug 2025 02:29:03 +0000 Wei Yang <richard.weiyang@gmail.com> wrote:
>
>> As David suggested, currently we don't have a high level test case to
>> verify the behavior of rmap. This patch set introduce the verification
>> on rmap by migration.
>
>I'm seeing many rejects here, so please redo against tomorrow's mm-new?
>

Sure.

>Also, seeing "assert" in the changelogs was a little surprising.  The
>term "assert" made me expect to see assertions, such as VM_BUG_ON(). 
>Perhaps "test that" would be clearer.

Will update it.

-- 
Wei Yang
Help you, Help me

