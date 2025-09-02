Return-Path: <linux-kselftest+bounces-40640-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 193E3B40CE7
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 20:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE3932083D7
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 18:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7CF346A12;
	Tue,  2 Sep 2025 18:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7RTEvT9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2071034A316;
	Tue,  2 Sep 2025 18:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756836636; cv=none; b=k0Krorl6ZKpiLkoOC2GfqUZNu8OubNC7N28gnYghQ685U4nbOpeFP1/SErVLGkAFCHVuIFv1uzV+lTgZrKpjSSLjYuE2bSlr4xfOPfL1qJSDkscvhlcqi6nceE2RYyJANvSXwse/50hRQjQ0iUaQPXq2RuEcJAnPh2vDFEHMMFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756836636; c=relaxed/simple;
	bh=mnD4JRGbk9W/QM5EuH31k1b1ffUiZwbDvhrc0zl10ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Si6vr48T8p3IxDtRxqrIbBCFsF3XCBcrKqC6WROeGdFcu5gMW2ogpgLxpVauyJ3jzOIWzaWvZ1pitQPPar4ohNnbqw0B8rUyKA9JocflrEdAgF6E5nEOh0jpk9C5kinHE/L1ifLXGy5CcJinCjj7aBSWhY94IWjJ6d4pY1JPDks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7RTEvT9; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b4c72885c8bso4029346a12.0;
        Tue, 02 Sep 2025 11:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756836634; x=1757441434; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=11SI7K2HrD1Xkcfg4YipKbfNlLrbJJRsWjUQWdPP85o=;
        b=E7RTEvT9DCLUalX5qqgIb1adpP1w3XtBkcNyhbLh6SN3LziI2J4vyJb0VhsXZ+yKRx
         0EMr8LjAgOnFi+qzuWyCstf5o8sMxGJ/oU7UEDcKKBtvmq9ZwxfPXEy91LInzf1WaY4I
         Zpaa+MnVRNHhnhUeCMi1xjWJBHLcYrjmzsm282OYz4Q+gqwd3d+T5ukATcHkx5GVjc6t
         Bw/uvgjGk4WrhXXyTADJNnDtUjxOptt8bRAPCsRcbgx5+6m08FeM1B83BQ7/HuYhwBOR
         LEofsCau59yd43oXQyij2XiZ5Rw+AFLLWIwI3WqXogi/Kg0c/b1fqwDsJsV4YDQkKk1h
         NChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756836634; x=1757441434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11SI7K2HrD1Xkcfg4YipKbfNlLrbJJRsWjUQWdPP85o=;
        b=Dm4bqIu9BfmHnOxSdkRU/pnsC11+8tIUo62Wl7wA+IBRevTygWMwjbv2nZ8hdRZRL6
         9ejONlL1lKTDoVnlc67Adh2F3NIxFwTRZGlbyaz8vYx77ImrWFUNCXkNbHsTLBLGnVft
         ruHUVThaAt/yOxNZiIDc7YgHJxo2kixHDOg83XrerknYBjfi9p6uAb80hZJLIY5p5Ai0
         cibQEwgkHmrxrc7CMCVHwdjoQsm5b4J3JsRRMPw6GCZjYHyRXHHOpgjRb+ImZnLayDZC
         tnbfZqaQ5bZklzpbT7ojPHWMGeHVZup8okdwDzw77uysHG1uUk1sghEmNJabeU8aZhaK
         EPuA==
X-Forwarded-Encrypted: i=1; AJvYcCUs99MItuhhO60ZfvrSouqJYGPwjr6BsABL13mS+QJRwanYwWGF2vVvr8O31cNpZHAE3LCw6oNgAl3/gIh5@vger.kernel.org, AJvYcCVQOwTTBdY32dJqRUJzzwnJi+ZR23g77j+bt4dLEsvvIfTimUtUuc4kZqltIWTLcwt/KLoVQiBo@vger.kernel.org, AJvYcCW0ofg42+KYXIFIObANRBEeG37bp+nubPLSq4ks1thP8JR2Gmj+Q7T02mEtZSaKqOOb6Adqo9Eg/iPMKdON@vger.kernel.org, AJvYcCWd4gKBavgtUHItqphzoY3IHiADOdPVtD8z3JRXp7yK7e0lcbqG7QNIVvDIlm9ILvyWULDkX2cFdtkGDjokPZzH@vger.kernel.org, AJvYcCXtMDMbqWRJ8B7SFd7Cz/WgTfaYIdT+IXhQwx4BQeOnksPwkVpgm5Ke+akH8JTkkOvHFYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCJ5JpVEXRQn7WNaAtX2Nj5LA4duV1pQz2qv4vrV/y+MvUBk8f
	B6vnXtcFFJIaXf+/8GQ1ObsOWmtAVyhSvBGnVFPZkl0AlmL+rhmpclFO
X-Gm-Gg: ASbGnctLLNc4ev9f1SYAh1bb6J5JTLVm+4p+QXBJNT/8aGx1G0ERIvTlspLTN7Vr/qC
	N3oq60PeH2YEPfaKI/T7grAdaqKua3SbGRdJJIyeTiibEp1fLrZ3sI1vCYehXmW2/ACoYr3a3AX
	2T8Sd+D9mLRpP7qhSTKCHklfpIgIHsCxjM32mb2dttwaOlltnupXLGIaQha8t8v+BWDnW2AwyGt
	5tfqXY/K19yP90RIqLH7ITRWvbYw3+Ho3zIYE6bRXQ4zMg3xwX7zkqaMtfNpCh0MruP4JpJwO4p
	Chn2PZsbcKmv7lYWbkuGZf0T2G30nhO3Lb0wRY9P4KKS18sQS+BRUuOqCLuJT0ZDzEe3xNxE13m
	+HpZtav/YZ24eEotcr3byY9F0aJLvTYTAM8prLUNWDQw=
X-Google-Smtp-Source: AGHT+IFi/A5kl+CSm9Pre9tgHAXuj4Y9/s3vbKAIdfdu32Djhb4qcTMLMePJS7ddZUuOGxsxTT3zRQ==
X-Received: by 2002:a17:903:230c:b0:248:ea98:3d12 with SMTP id d9443c01a7336-24944acc7d6mr170727225ad.40.1756836634401;
        Tue, 02 Sep 2025 11:10:34 -0700 (PDT)
Received: from devvm6216.cco0.facebook.com ([2a03:2880:2ff:1::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b2570cfb0sm18256955ad.139.2025.09.02.11.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 11:10:33 -0700 (PDT)
Date: Tue, 2 Sep 2025 11:10:31 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
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
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v5 9/9] selftests/vsock: add namespace tests
Message-ID: <aLczFwjAClnFvANG@devvm6216.cco0.facebook.com>
References: <20250827-vsock-vmtest-v5-0-0ba580bede5b@meta.com>
 <20250827-vsock-vmtest-v5-9-0ba580bede5b@meta.com>
 <phckm6qx2drazblg4fsheqe4meg7likmvhbyquffwct4xj35ub@ddz2iikovcq5>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <phckm6qx2drazblg4fsheqe4meg7likmvhbyquffwct4xj35ub@ddz2iikovcq5>

On Tue, Sep 02, 2025 at 05:40:38PM +0200, Stefano Garzarella wrote:
> On Wed, Aug 27, 2025 at 05:31:37PM -0700, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > Add tests for namespace support in vsock. Use socat for basic connection
> 
> Are netns tests skipped if the kernel doesn't support it?

No, will fix in next rev.

Thanks,
Bobby

