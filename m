Return-Path: <linux-kselftest+bounces-35573-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15155AE312E
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Jun 2025 19:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90F15169C51
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Jun 2025 17:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB8F1DE881;
	Sun, 22 Jun 2025 17:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="qkUd7OyY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4141632DF
	for <linux-kselftest@vger.kernel.org>; Sun, 22 Jun 2025 17:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750614016; cv=none; b=irmDFploLUGxdnZLhniPMRjwniX+mFGcdHkY0gqq3/UEeJb1GVnXlUS+GfAxzQdRasWO/fx8iHEQSeVZF4jCta8av29JVBaaNovPPeSK2E1HsdEAwUNDk+qkLmopia/hot8lZYC8+fUSaaaNRMng6j5f2wNZbRj41VAXNXy4ehk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750614016; c=relaxed/simple;
	bh=JBS6katIuy9abXAwM/EgfQ0vNXuWJoKtGDCgsMvppwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y29TKvgOW9pgvJnQsG/rgwOQBwPr6OcEapfAU6YUw3Udmh7F1fMhuytEn45o2VLcm9coNrVJ/NQvtTjQ/H/3OxlrQ2L0TSb5OSmS2VrvRnzFzMYVPbzCVVnzzPtoe0MImW5iygXM9ZBLtcnKnjaQgi1FI0xyyeUh5uCIzo1Hsng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=qkUd7OyY; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4a58c2430edso38608671cf.1
        for <linux-kselftest@vger.kernel.org>; Sun, 22 Jun 2025 10:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1750614013; x=1751218813; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JBS6katIuy9abXAwM/EgfQ0vNXuWJoKtGDCgsMvppwk=;
        b=qkUd7OyYEjZA3lCPXBJ2EiCNjnegCHE58l9b9rp5DFzG3W534etSXmVuSkC8fyOX4c
         2yXHCPoFE9XUeoh2ixdyCTqX7bI9GOse/fsmLV6qJoRGE96GFREHnOSrl+e4eNkhdO/e
         czNg7xL88rWOvVdDmnkcZTQZYyKdCzp/YSWikP66SQS0kZ9xReRjfOGgQZo1rgXHZX4D
         mJ/syG00Vo7x1P8mvuc3go99/o9iGFJ5Vu0DgzaT6F+YbQX9l79sDDxhucVD+ydqscaa
         GNPKD6NQHuoo2Q2R9qwfIH+XxEBc29Snrqnx5KKh3LB9JOBRq/BFyRUoKcQxK5o37gs2
         v3Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750614013; x=1751218813;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JBS6katIuy9abXAwM/EgfQ0vNXuWJoKtGDCgsMvppwk=;
        b=XSkVnh7dz+lDRYPUcH/c36lK5CUvEvhAmvpNVIfyjZgYFnfzKX4y7YGlMrKins7Q1T
         3mWU4j1TJnCB0EFtMenrlYsBORmU6ok1p3QaFDZM7NLNTYswd4uMYd5EsygjT3hFgl4f
         SfOmtVSI0UAvf9cTlOvhEKAST3wvk2REQ2K4YJbp8VQZyLX228PIGsVEGnv5UkVud+O6
         eo0lx946nx+Ov5e6yMeDPijD/ZBOF5NtRwhod/1dANr8mjbnDvvgGeD0wfuwJOxerIAt
         ZY+vf0cQrKug6IPENSHz9xOTqLKizNOiUesf3Pojj0m/oMxPoga9eEFlmrJHciFM727r
         cj2g==
X-Forwarded-Encrypted: i=1; AJvYcCXZiKg4rSRDFVKKNhzuHxFQhAZtzjLjFKSKKFgKmCjkCgnmCHEZ2kW/qG12jOGwwraFQniX/V1i++PLFYl3vTo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/zOeqztU57k5Po9QXJzIzpC4HSctLupo5HMNhOd9sWwYIKcQ2
	Sj/UEi3NvRPKJNbPmrbOdsupsbzuU/BG0v3/2UR3zrhD1Uy0vs4KEx1oBUSbE0Eyw4VnLorLLur
	O+kzlIMSsz8SaqjyelmQtCUyT7BeMRnBcEP2Gdjcs/g==
X-Gm-Gg: ASbGncstlQaqkLJxHLX/2wZFNycB5wDfHgCmpYIo5VNp7o5sw4ILVNnuq+k8+XyhZpJ
	6DRQYijpJGZGTf13ipX1/i9zUUS0rbTsItVaiuaSsMLqw2l+QXe5u5UnrYplrei3e/wWvnLmivX
	KR6cNSDUVamnwXOCPQLasEW9aVehsMKwk0jAeYXmZxsppxNpVfVRwN3PC0awuw5k6ourVqivLYE
	dJtFcbKHo6N9eHf
X-Google-Smtp-Source: AGHT+IGAQVA4j9B6bOXEQavSPQk4pUsTIQfktiOkSDRcEtYWtj2nMKnJm6GAf6TwLLKYEA7597CW46OoVjUcTVc0rKg=
X-Received: by 2002:ac8:5707:0:b0:494:b247:4ddb with SMTP id
 d75a77b69052e-4a77c2d6173mr135279261cf.4.1750614013493; Sun, 22 Jun 2025
 10:40:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530-rss-v12-0-95d8b348de91@daynix.com> <20250530-rss-v12-1-95d8b348de91@daynix.com>
 <CACGkMEufffSj1GQMqwf598__-JgNtXRpyvsLtjSbr3angLmJXg@mail.gmail.com>
 <95cb2640-570d-4f51-8775-af5248c6bc5a@daynix.com> <CACGkMEu6fZaErFEu7_UFsykXRL7Z+CwmkcxmvJHC+eN_j0pQvg@mail.gmail.com>
 <4eaa7aaa-f677-4a31-bcc2-badcb5e2b9f6@daynix.com> <CACGkMEu3QH+VdHqQEePYz_z+_bNYswpA-KNxzz0edEOSSkJtWw@mail.gmail.com>
 <75ef190e-49fc-48aa-abf2-579ea31e4d15@daynix.com> <CACGkMEu2n-O0UtVEmcPkELcg9gpML=m5W=qYPjeEjp3ba73Eiw@mail.gmail.com>
 <760e9154-3440-464f-9b82-5a0c66f482ee@daynix.com> <CACGkMEtCr65RFB0jeprX3iQ3ke997AWF0FGH6JW_zuJOLqS5uw@mail.gmail.com>
In-Reply-To: <CACGkMEtCr65RFB0jeprX3iQ3ke997AWF0FGH6JW_zuJOLqS5uw@mail.gmail.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Sun, 22 Jun 2025 20:40:02 +0300
X-Gm-Features: AX0GCFu7f7UEMKygSwaRuFS-QXgCw4dhQ6kVLLsvANPI-_VjCLQSaQpxwUYjwO8
Message-ID: <CAOEp5OcybMttzRam+RKQHv4KA-zLnxGrL+UApc5KrAG+op9LKg@mail.gmail.com>
Subject: Re: [PATCH net-next v12 01/10] virtio_net: Add functions for hashing
To: Jason Wang <jasowang@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Andrew Melnychenko <andrew@daynix.com>, Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
	Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"

> Yuri, can you help to clarify this?

I see here several questions:
1. Whether it is ok for the device not to indicate support for XXX_EX hash type?
- I think, yes (strictly speaking, it was better to test that before
submitting the patches )
2. Is it possible that the guest will enable some XXX_EX hash type if
the device does not indicate that it is supported?
- No (I think this is part of the spec)
3. What to do if we migrate between systems with different
capabilities of hash support/reporting/whatever
- IMO, at this moment such case should be excluded and only mechanism
we have for that is the compatible machine version
- in some future the change of device capabilities can be communicated
to the driver and _probably_ the driver might be able to communicate
the change of device capabilities to the OS
4. Does it make sense to have fine configuration of hash types mask
via command-line?
- IMO, no. This would require the user to have too much knowledge
about RSS internals

Please let me know if I missed something.

