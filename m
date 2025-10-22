Return-Path: <linux-kselftest+bounces-43724-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB99BF9711
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 02:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98E783B1599
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 00:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD951922DD;
	Wed, 22 Oct 2025 00:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEYxaRC6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BD61509A0
	for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 00:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761092323; cv=none; b=adIiwAGlLNelnn/fosXYkt4j9/wLckzzlNXHlQprwxxX8j6krtOW4evHAXDtNbvWEZgU6SMuQX22C62cPBmGvJ7ehCHghAm50B+W7i5SijdQqyVQGl+vh/EDAKuzxXELN7WBquB2c9evXxy4+S0IrfjSnmEJSzdQdKpt+a3RngY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761092323; c=relaxed/simple;
	bh=e7zZqGzrVyuJ5QFyUVE7eGJWKcfl4COyVHk9MxNeNKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ppfo/mMTiTznZQZewWViep6jOjvUolBF+bsxZcNbwg/RpRcezztsIiETGY58tozqcc+qEJse7KmFNib+EvwCPjEPkuShAfAh7h6SwLbl4V3MNZmmHCs3VXv7TqPbOBc7dXl2BotAi4/VEGcSs6H3eSjh+mm10dT/04UXVxFEx3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LEYxaRC6; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-784826b75a4so44030257b3.0
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 17:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761092320; x=1761697120; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/VVHhrbKGyn2rHkoA+yo5pqhCOh1qQTtBCOhpEVSIKI=;
        b=LEYxaRC6RrM323rjsaoom5Qmq/bAc2SaTJQX8GJ41fF9wS6dF+ydCMuObV/5vRa9eB
         SYzYEkaIUsxJnYJGDOSck7f5EU9vx9otxlhq1x+6sXovUgcPoHhzkS1/sr+MeTTofOqm
         kaqUIhe3CEayD/uRA/QRjxQKOf5/hfvNSSFokoiA062H/g1f6d4cgxhk8wQ2qHOqAWA1
         eVHfFwRFvzlDceNZFLxCxEXtyF1o/6x4+magzUtAbYoQ1/0Hwm2zFzVNHt/0gaLM4WR/
         +Bg6rdX7+JB7kTTKBRV1FQh/ebFcOfaNMgNs1sN5dVUKU0p7jMbVBrQMcaEqRjUmbe0p
         fT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761092320; x=1761697120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/VVHhrbKGyn2rHkoA+yo5pqhCOh1qQTtBCOhpEVSIKI=;
        b=RjJMtJY2y4d7y70AoaFyOF+Ys8+Xob4DZnd1HU3IsmU7n8f6QQPywJvDn3X1frWng2
         u/m4eUd/yewiqOueHE8bSbRJbBa4iA6ZBl5Pxf7QcDoNqGuHw38vN2Wt5nCRyxc1VDjW
         p/Zeq9LvTbnrusCmIVmdsJhnzxWgx92IJJLoWvN531R0pvoh2l1ajNVj2ITwHjhuZ4QR
         8ukTRT1bRli2gjYyKQ+mKCUzOAgV/zNNFrxcYTos+GOA1kF39FxQovXH80kKn7c5ssn/
         rLtzn26gupUlqpOaTgzRORST+GGITgTViCVEM9eQA+ySzt+o5VmJAQ19nK5c1THv65yG
         Y3Aw==
X-Forwarded-Encrypted: i=1; AJvYcCVMIcY+qXOCFImpyRufbMvW+wLBhauqXTNBkO/SNBxKVRC5vVJ0Nf88Ox+QFHQxjniLUCzOGVpwFrEodmbdQVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFhGr4R7EmIDJUgteM3onWH60ATiaEUyeT48hj0GC9x0c5pKez
	N6pcXkjCym+LpOaamLPTz+WGp11dJpZs+0wc75DMkI2B+da3bZb8hcxM
X-Gm-Gg: ASbGncu6EqrGoHThJuBeql4NbACAjFH9uvfPHMp0Z+xUyMW1wg114OsNwzqDgmWE7+3
	n/8uch/rRqrIpLtC/8uXWLWQsA8JmpDysXAdvlRjpawzn/AAAtnIb3QvHaBhicqGzMYD9jeyzD9
	IxQmBR88azSHY9HqhcOfm9S4HjH1xg6j1mVelqc/p6XJrbj3/hB0YgdB3lR4ixoU3TEWoiBVDP3
	dqs0B2bRWRtXBDalo374JdtrY3RJ8kxYytA1GfR1WHEaQWvdH2n+r7zQjxKXKP0b70dSPmsabaP
	7/VnKrJMo9yjwXI735FxM0IQGsP9diRy99mi5WoWKnXcN91Xyxa8oZOwxsj3iyAa3DiEh0Bm77P
	rBO4CKVqiF5ED5KpZTmVCU6TM1QqwCXz4w7NxgymryceL+WPlk/x9NtLxv3ZYdjjUSorsKP0dND
	Ct9/ZYVes6JweIOkp0A/88kSC7LGhdWrm+PN1J0Ob1i9JDRhw=
X-Google-Smtp-Source: AGHT+IEqYiiuWqadmrSa+ocB1xo5kZsyd7pE12wgODlf319TseLh48deAbNiLMyHfUUvkPdfF1Gc1A==
X-Received: by 2002:a05:690c:45c3:b0:783:7266:58ef with SMTP id 00721157ae682-7837266619dmr152519147b3.5.1761092320133;
        Tue, 21 Oct 2025 17:18:40 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:59::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7846a6cc14bsm32765777b3.60.2025.10.21.17.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 17:18:39 -0700 (PDT)
Date: Tue, 21 Oct 2025 17:18:38 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
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
Subject: Re: [PATCH net-next v7 08/26] selftests/vsock: improve logging in
 vmtest.sh
Message-ID: <aPgi3vSJGGfBovRf@devvm11784.nha0.facebook.com>
References: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
 <20251021-vsock-vmtest-v7-8-0661b7b6f081@meta.com>
 <20251021170147.7c0d96b2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021170147.7c0d96b2@kernel.org>

On Tue, Oct 21, 2025 at 05:01:47PM -0700, Jakub Kicinski wrote:
> On Tue, 21 Oct 2025 16:46:51 -0700 Bobby Eshleman wrote:
> > Improve usability of logging functions. Remove the test name prefix from
> > logging functions so that logging calls can be made deeper into the call
> > stack without passing down the test name or setting some global. Teach
> > log function to accept a LOG_PREFIX variable to avoid unnecessary
> > argument shifting.
> > 
> > Remove log_setup() and instead use log_host(). The host/guest prefixes
> > are useful to show whether a failure happened on the guest or host side,
> > but "setup" doesn't really give additional useful information. Since all
> > log_setup() calls happen on the host, lets just use log_host() instead.
> 
> And this cannot be posted separately / before the rest? I don't think
> this series has to be 26 patches long.
> 
> I'm dropping this from PW, please try to obey the local customs :(

Sorry about that, since these selftest changes were all part of one
messier patch in the previous rev, I wasn't sure if the custom was to
keep them in the original series or break them out into another series.

I'll break them out and resend.

