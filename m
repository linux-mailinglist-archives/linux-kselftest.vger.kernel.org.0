Return-Path: <linux-kselftest+bounces-38341-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D089FB1BC59
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 00:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 085C118593D
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 22:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C26725A64C;
	Tue,  5 Aug 2025 22:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kwj87oI4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F1C253932;
	Tue,  5 Aug 2025 22:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754431422; cv=none; b=FZGVyxVflKUIGpPG/nYgrBDZksp0ahBJd0p/8ofx+JTrz+VUFPTLyTbw3Mp3JZ4UaT16zpwckBZKyVd+9bQ6zNxqTf78RwqWHWNLJguhpQnY9Gs76ta8qtKtetH5j4/guTlxDxVVUWlPiU9wFrrVDLR90BxBtXCI9+KVlW7QC5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754431422; c=relaxed/simple;
	bh=3J4zAqb63bH3VX5N3JqAiFgpLhLxiKG6g2wX0yan0bQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rywhk6tXkARAc9lJvGoAi4JLC+aR1lwEDSPQyyNkpoA0ClMc4/ogwkJoILJvvMfCbW8jZnD/BFszinFbJLK9q3y9ZLtm01quTUkDIB4DEzsjzx3mi4aQgvIY+d9uSRnqlmGrKl3o45wr/18V6qtIGVeACVbl+yZ+w9LzkECsxx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kwj87oI4; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b271f3ae786so4880576a12.3;
        Tue, 05 Aug 2025 15:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754431420; x=1755036220; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gKL9Qs4he/u4QmnFJ98xlj5EFrnUf0t+cD9K1mfke1w=;
        b=Kwj87oI4KJFb9byFqMBSegNqKwtUaKkA3ejQZ/qH3SD3CBjBFZ2rssdR9jMyfEMD9c
         +wD5M6fgYbIBc7b6r9qoJvfizEHpKOixYSquUp48CxIjxlnizQYCW60SnXJduPznibvo
         hKPpNZIJtEBacIGv1+rUON5cJlNgkwPXWdk8zQsT2mNvIyTr8N2X4pRr9WS8gTkBOHAU
         H89y82tGpObe38ljPSe+0WWhfn/MF3ziyfiR2OoknXvTgkUs0kUbVQ1Ba8SIcS9H+Nn5
         BSY/glXsacygjzSBvVXrqe7hXsg7q0mpkqT4wcX+w7l7x8mT/bI8FYBq710FuJWzSRew
         /qmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754431420; x=1755036220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKL9Qs4he/u4QmnFJ98xlj5EFrnUf0t+cD9K1mfke1w=;
        b=hgiG3A7pLXfAbi4alwznyrPTxJRHn5Oxj4ZXRhfObTC4uYosNoMbH10RcanWHWF9w7
         XnxrvUPAmNZ/TBiPNnEyCVAbSsJ/mMjZtJ7D9BRS3GO/2FTxAVaMtbejFCW9l8d3gB4Y
         lqm5ZIRN0xnvU0vHiw8JPA5aGMJUBbCS3dN8niup/pZQ3ZyfGFirnnTyHAVHMncBxKK4
         fAWVnzNa3tMfYgeicgpv22t8xZ1uAxfmLlhk1d7EK2iRsn/IGnpP26OzCTwKtuUh3inu
         FkQuBSJJVWH18dj8qI/sFUQNFSFsnh/8i+wdV8YUiFbbeB67JMkNT4DOdUPqG5Er04ff
         ACHA==
X-Forwarded-Encrypted: i=1; AJvYcCUjb/lFxAUnceEMgsGg5GAf1AnIJgW/UjHQCOTBaMLjhQGMD8jtV097baVV2VZP92dyFVXSov0395pKP6Ks@vger.kernel.org, AJvYcCV4yk+hYtbWG+2lBbHYM8FS5Z7eMW+faEPBDuIzW4PGf5/zlnrXpODsAVYyozLaUc26ttHe2lO8@vger.kernel.org, AJvYcCV5lBgA3LbPOGYIM9rJ3o1vkOHxV4eZROVbIldZPYFP09z1od33Z2Vz/h+4XISpsqtvd/KDQ+b2jUZYCX7N@vger.kernel.org, AJvYcCX943WofalV3gKZMWdt1nlt8TnGCVexEOHamE94Ny/w07hTpiYRzN0u6/LIHSjzzqxHzHaoQMtEmdYxQigClTfx@vger.kernel.org, AJvYcCXd98ha9JCYhao1c0vyHICCjK1wM+/ZNLOJ/qeoWR0F2jgdUpt/aAKrqOkKq+eE0En+N+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQyD3AzIgpozDDuQDVMJYsksBw+LJlwjRqint4SmfUU3Gq9E6d
	L54lGSOxkE5zKF8NpoOEHe5OiTdLSeyWhw3ctnNbwBaSNbF1suV5hsbA
X-Gm-Gg: ASbGncvijmn8ffzy4zCwyf8EaR8nlUcQrm8ML39ynfE2s2/5r0sH/9satZ3L0k1WL1d
	cFlJL1710ioKItEvBxSYiqFppSQc5cySb7G3g+3s7cxPfH04kWsoKUVxBajKd34g5BCgCYXUkdR
	fIcNjQ8VgO0IFk/Upc8xXdI1Tp2wMLcEjnhRnjzKOlmXkW9yKFR5tS0UWI9CFfsgEaDf3as5RGh
	/DtDkWKgKkpbwYwafUKkeSD2Hkd0BZPxj9g0vrZzOcn+Yo3q7lfYorBdmCy2bqz9khjRrqSJpI/
	zAFvonQGlsIFkla9++IE4zuD1Jj5UEIwKllY225+ZovW0S4BIHN8OUPGPaMsDle4OOHayWVWyGG
	yo8PFpl0kNUEd9eAxjHCbhztDA5sSgtuQBuHybZqALfU=
X-Google-Smtp-Source: AGHT+IFfzRZXbjYMaKuhhzfUCiya/wrLqxSvHXQBVysGY1NlsmWhfMPYkWw2Vxzm69yDdFqszb4ZOg==
X-Received: by 2002:a17:902:cccc:b0:240:640a:c576 with SMTP id d9443c01a7336-2429eeb9837mr8222175ad.15.1754431420427;
        Tue, 05 Aug 2025 15:03:40 -0700 (PDT)
Received: from devvm6216.cco0.facebook.com ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aafa77sm141295305ad.174.2025.08.05.15.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 15:03:39 -0700 (PDT)
Date: Tue, 5 Aug 2025 15:03:37 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH RFC net-next v4 00/12] vsock: add namespace support to
 vhost-vsock
Message-ID: <aJJ/uWhqEu1TG1Kz@devvm6216.cco0.facebook.com>
References: <20250805-vsock-vmtest-v4-0-059ec51ab111@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805-vsock-vmtest-v4-0-059ec51ab111@meta.com>

On Tue, Aug 05, 2025 at 02:49:08PM -0700, Bobby Eshleman wrote:

...

> 
> Thanks again for everyone's help and reviews!
> 
> 
> Changes in v4:
> - removed RFC tag

My bad, I didn't notice I still had the rfc tag before sending out with
b4.

This is ready for review and not really an RFC. All test cases passing,
etc...

-Bobby

