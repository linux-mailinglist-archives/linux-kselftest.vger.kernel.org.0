Return-Path: <linux-kselftest+bounces-40638-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E0CB40BAF
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 19:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F622487231
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 17:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF232341ABA;
	Tue,  2 Sep 2025 17:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvGFNRnR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF1023D7C4;
	Tue,  2 Sep 2025 17:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756833011; cv=none; b=N4ZkfrLFnQ0lKuWwEvZHjtDRmB+IN7wrPfXO/ml+IqxTWM71sHIZXOFRbwArODYVj9IYktDgIBpvo7Wj3fQQqNqNt+EKszpDM+2M48n2Whci0HaWwcbYaRYVPTpBp2RkCrNdG7uKlLEZkqjNmkPN7N+pdgy5yw6p87qb8ddlIoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756833011; c=relaxed/simple;
	bh=EF6aZqNIoSXa0kptmEVVRLVollrxdh2NWJJq1QCOmQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YwIGksdHEI/kdu71i2fmMNf4tqyOZeaif4tQduNEME7IQo7BqyLC07Dv+DA2H1TWBtKrpklTfJu7IQeneSdiWqPxHm4S7lw6Cx1NbU/j8fXlKyUdaQ+nff/+r2Gyw8Q9C6esSoxE4/drc41S7+p2NPnXDmEywv0Gh9MaTRg4yJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XvGFNRnR; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-772750f6b0eso738510b3a.1;
        Tue, 02 Sep 2025 10:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756833009; x=1757437809; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ihQjC9yJ1X4I7i2TJOoe7K1INvxzQRyYcVly+4F6YMQ=;
        b=XvGFNRnRZagP3hjX+6WSklFhFVWd2uJQyFRvv8KIzbT8yRDDm/GHsbSsPzqyyUiCt5
         +YA12b72b3vJLEXrjFF5dqP7SO54Wb1fVLlyd9DHs1NsLTdm0Dnvern50PE0L5iVpLir
         qkWxd2zCGaIEM9g6syaAXrLjvtxKOTQCCqNIcblOVnFM0daDMwc+WhtRDNBJEDUCvW6e
         VZ8pnfXdnBfYpLymIw0IACBIbGLQqn25b8vmwPBGEUZgAdJBuhqEnwBRMDJlIeAk84XN
         YBlsuIKFzB8tL3yu6SjDUb9C4COtjqhhsX4NnA4C7v/RbAKByRBWgLc5epWj0vGj9zks
         rqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756833009; x=1757437809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihQjC9yJ1X4I7i2TJOoe7K1INvxzQRyYcVly+4F6YMQ=;
        b=rSMIJmpiY9SEoTxJsVVWYEEs7j5TactwdaxtR0cNMgX/ibVErwWgai2so/nk1rVM0+
         Q3qYQhzgU91Rgdrw7CCEQmHYIkSMjp3PnCLpGhENCEF5kQexKBE2SrLlABIwQnPYuj6N
         TKNQeN/YMQYX5qK2Mkv7J+9EE8DUeq/OT5gBgi2rA2NLeaYk3YECBReAoOiWJVHNWV+d
         WMTCYOS3uuyQGHEbkMJJOtmePRImsRMKeGBCr+Z+jBdm4UQOnl1qVmHYI4np07F3Oitf
         ohLjzI8IyqfcH/ZFMeM9LJN/OYw4fp0UG2s2oB9QXlvmX/klbaP2z/AEgkZe1QgChZKl
         kO9w==
X-Forwarded-Encrypted: i=1; AJvYcCURw1Pz4PatowxBCXe39KI9PGOS6In8qsoFOP/jsXm6zcxQsl3+EsMi4fb54iH5Iywm4pM=@vger.kernel.org, AJvYcCUrMHSCbZr2zu9X2D1Y9YJYIICZ74bxk1fZ8xQnoWl4KDt38ZhWJQ22mUrUiHVjjjcZ9Z4TcElE@vger.kernel.org, AJvYcCUygK8hHVctNanF3NXJoDyW/v7xRJyoGSYsS/FqJoIC9ffFZVbWCuABO5+cb/MUDP/0l+8G1jMjE9lrhRbz@vger.kernel.org, AJvYcCXW2bJmX2tXay9g63GGqPhlV++BvS2nOzy0BViAvfWfH4rI/Yvf+Demh3W9zk0so3m1Xf6iRlH40bXlDhpZ6Y9q@vger.kernel.org, AJvYcCXhP/6trIPrb+6yw2t36Fh8XgmjVu7Uq2Lb+CxUIrljuBYrHbV3qiF/NdGRQzQQavaSQa2GTGFT8FUnBQ0H@vger.kernel.org
X-Gm-Message-State: AOJu0YyveaIQnBXWueA+xkAre3ygbjEP+PH0b50ewXOiXzaUDBFNcMrL
	Xyp5zBITYRde0xu181ZRYpD4/rC+EZZcdTMAYrF5RUyrHDKcvy6TtBij
X-Gm-Gg: ASbGncvF/VJpcZJQwGFHAvbuAqS2TPNPPUVRsLH2lIDU++bioAtOjjctZ/1HnQfSyOt
	yZqPL9jkMXYY8kS2GFv7S8fm2gNQltPkP/7U9eqymhkI5myRfCR2umyc0tCI8HpkCr7COVCwiKG
	dALp2VH96W5W1bJC7Bbd/Rt6GdMZa4BI1upqrLfY0i2sV8+I0JS6qdkb24HdpFZ0iKUPS6Yifu/
	wAth4LvdvEFQy+0aMP+/Gj6j7XQdWOAwSNz71j3SVVMzxj/9EFFlxx6J9Gk11y9XwZRAoDuwAnE
	cloFAv0PYu6FC7RARqkVn5hp/GiblxcqonUlHT0jxvhvVwth2frxPhy0AchMZvIdUuUJU4Wecdx
	xJzX29FLntt80wZLZSrKYFS4IQhZEnHQMQQuUFRK26D4=
X-Google-Smtp-Source: AGHT+IGyUUiPrfchRjHRX3crNHUYbFF9RNjkv+OcfvEakWvZRQN9OH2MzLTdAngcH4AMJjIzQ+3iyg==
X-Received: by 2002:a05:6a20:1093:b0:244:58:c159 with SMTP id adf61e73a8af0-2440058c3d1mr3642462637.22.1756833009146;
        Tue, 02 Sep 2025 10:10:09 -0700 (PDT)
Received: from devvm6216.cco0.facebook.com ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7726a0e7cb8sm3845860b3a.58.2025.09.02.10.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 10:10:08 -0700 (PDT)
Date: Tue, 2 Sep 2025 10:10:00 -0700
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
Subject: Re: [PATCH net-next v5 3/9] vsock: add netns to vsock core
Message-ID: <aLck6IIS3AiDJZPg@devvm6216.cco0.facebook.com>
References: <20250827-vsock-vmtest-v5-0-0ba580bede5b@meta.com>
 <20250827-vsock-vmtest-v5-3-0ba580bede5b@meta.com>
 <gncp3ynz3inufzex64sla2ia3stjsen2n3hwhfuykdhmpuuegu@7hk5q2hjfxkv>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gncp3ynz3inufzex64sla2ia3stjsen2n3hwhfuykdhmpuuegu@7hk5q2hjfxkv>

On Tue, Sep 02, 2025 at 05:39:10PM +0200, Stefano Garzarella wrote:
> On Wed, Aug 27, 2025 at 05:31:31PM -0700, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>

...

> > {
> > 	enum vsock_net_mode ret;
> > diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> > index 0538948d5fd9..68a8875c8106 100644
> > --- a/net/vmw_vsock/af_vsock.c
> > +++ b/net/vmw_vsock/af_vsock.c
> > @@ -83,6 +83,24 @@
> >  *   TCP_ESTABLISHED - connected
> >  *   TCP_CLOSING - disconnecting
> >  *   TCP_LISTEN - listening
> > + *
> > + * - Namespaces in vsock support two different modes configured
> > + *   through /proc/sys/net/vsock/ns_mode. The modes are "local" and "global".
> > + *   Each mode defines how the namespace interacts with CIDs.
> > + *   /proc/sys/net/vsock/ns_mode is write-once, so that it may be configured
> > + *   and locked down by a namespace manager. The default is "global". The mode
> > + *   is set per-namespace.
> > + *
> > + *   The modes affect the allocation and accessibility of CIDs as follows:
> > + *   - global - aka fully public
> > + *      - CID allocation draws from the public pool
> > + *      - AF_VSOCK sockets may reach any CID allocated from the public pool
> > + *      - AF_VSOCK sockets may not reach CIDs allocated from private
> > pools
> 
> Should we define what public and private pools are?
> 
> What I found difficult to understand was the allocation of CIDs, meaning I
> had to reread it two or three times to perhaps understand it.
> 
> IIUC, netns with mode=global can only allocate public CIDs, while netns with
> mode=local can only allocate private CIDs, right?
> 

Correct.

> Perhaps we should first better define how CIDs are allocated and then
> explain the interaction between them.
> 

Makes sense, I'll clarify that.

> > + *
> > + *   - local - aka fully private
> > + *     - CID allocation draws only from the private pool, does not affect public pool
> > + *     - AF_VSOCK sockets may only reach CIDs from the private pool
> > + *     - AF_VSOCK sockets may not reach CIDs allocated from outside the pool
> 
> Why using "may" ? I mean, can be cases when this is not true?
> 


Good point, will change to stronger language since it is always true.

[...]

> > 
> > @@ -2636,6 +2670,137 @@ static struct miscdevice vsock_device = {
> > 	.fops		= &vsock_device_ops,
> > };
> > 
> > +#define VSOCK_NET_MODE_STRING_MAX 7
> > +
> > +static int vsock_net_mode_string(const struct ctl_table *table, int write,
> > +				 void *buffer, size_t *lenp, loff_t *ppos)
> > +{
> > +	char buf[VSOCK_NET_MODE_STRING_MAX] = {0};
> 
> Can we change `buf` name?
> 
> I find it confusing to have both a `buffer` variable and a `buf` variable in
> the same function.
> 

Makes sense, will do.

> > +	enum vsock_net_mode mode;
> > +	struct ctl_table tmp;
> > +	struct net *net;
> > +	const char *p;
> 
> Can we move `p` declaration in the `if (!write) {` block?
> 

yes.

> > +	int ret;
> > +
> > +	if (!table->data || !table->maxlen || !*lenp) {
> > +		*lenp = 0;
> > +		return 0;
> > +	}
> > +
> > +	net = current->nsproxy->net_ns;
> > +	tmp = *table;
> > +	tmp.data = buf;
> > +
> > +	if (!write) {
> > +		mode = vsock_net_mode(net);
> > +
> > +		if (mode == VSOCK_NET_MODE_GLOBAL) {
> > +			p = "global";
> > +		} else if (mode == VSOCK_NET_MODE_LOCAL) {
> > +			p = "local";
> > +		} else {
> > +			WARN_ONCE(true, "netns has invalid vsock mode");
> > +			*lenp = 0;
> > +			return 0;
> > +		}
> > +
> > +		strscpy(buf, p, sizeof(buf));
> > +		tmp.maxlen = strlen(p);
> > +	}
> > +
> > +	ret = proc_dostring(&tmp, write, buffer, lenp, ppos);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (write) {
> > +		if (!strncmp(buffer, "global", 6))
> 
> Are we sure that the `buffer` is at least 6 bytes long and NULL-terminated?
> 
> Maybe we can just check that `lenp <= sizeof(buf)`...
> 
> Should we add macros for "global" and "local" ?
> 

That all sounds reasonable. IIRC I tested with some garbage writes, but might
as well err on the side of caution.

> 
> > +			mode = VSOCK_NET_MODE_GLOBAL;
> > +		else if (!strncmp(buffer, "local", 5))
> > +			mode = VSOCK_NET_MODE_LOCAL;
> > +		else
> > +			return -EINVAL;
> > +
> > +		if (!vsock_net_write_mode(net, mode))
> > +			return -EPERM;
> > +	}
> > +
> > +	return 0;
> > +}
> > +

...


Thanks for the review!

Best,
Bobby

