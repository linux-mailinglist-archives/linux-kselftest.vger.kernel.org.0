Return-Path: <linux-kselftest+bounces-40685-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26824B4248C
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 17:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3FB968236F
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 15:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31562ED852;
	Wed,  3 Sep 2025 15:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EsxfSja0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7A13126CE
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Sep 2025 15:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756912279; cv=none; b=U8pQGGs74xLQHEvn5fMUoLWPRg52moH6dctm/2gSHUTSeTjI20jXLK9aBi5ZJ89SR6O8UlmVBlHkcsDxo/iUI5bq1L8TwbxjX+cGGtH6CC5OMPn0wlq+jHd18pL6ua248FqtJ62ZdEQ2WfPkPG3kBmOSYSR/xFB5wlKJr3cSFws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756912279; c=relaxed/simple;
	bh=JXSVz7KY42vKbxGMlr4D8X/NrCa2UHXF89XhYFg4TY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NdZw9O03OCop38JnJ49Z+sR+DPEWgdqQSa69/10wA+3VC8VPaLEf4m8tg/tORcZ7pCIU9H7S/6aRL1M11lBTe9cnL56+06ADSbU4dunKuWrh2evL4VbUBdk2y8euxVISHN7WOvuP78p7x7Xnsink9VNcg0MX5dVrsOhnLgkYDb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EsxfSja0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756912261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YuF64BuqEaUcQL/64doA3RnjEpMRLrvthbeCNCxA7jk=;
	b=EsxfSja0fsJwwvljEpnVUong1gk3OHFzDH/C0uBCUlIkJzfGmVF/5YlBtlg4AOxmWtuJef
	ZLWpke+l6kD4lCJBtMcOwbNmyzEPnl7I7yv3HY+L/BV0u6SSfe355ZtDtBMvWY/ezk6NU0
	wbMFYgpQJWFqH2/13Y1ZuqbjTzwFN78=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-4D21b4LFMdO22z3xlpv0eA-1; Wed, 03 Sep 2025 11:10:47 -0400
X-MC-Unique: 4D21b4LFMdO22z3xlpv0eA-1
X-Mimecast-MFC-AGG-ID: 4D21b4LFMdO22z3xlpv0eA_1756912244
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-61ec5ca1dfbso2586036a12.1
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Sep 2025 08:10:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756912244; x=1757517044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YuF64BuqEaUcQL/64doA3RnjEpMRLrvthbeCNCxA7jk=;
        b=OgZAs94HfyHuwVgXeyJZH5N8IO6mnWnsUaB+oXTUrr2H5Oi//+yMyjNK5jOJTWQUnH
         aeCshq3VvgbCFxYG0K8RNhRyVNyJF8vhRVa4nzdifz1qc/Nv5TZet/9NRjucmBOL5EO/
         kIAhWW5EJBms0AdAkTwMIkyQzh0WAFtUzC0ycJxIjdirRIOnPMttt5X3tCBdhTaM3Usx
         H+7SsUj6L6Gy+kPKVd2Ry4tV3KHFEt4DLkRM21m3I0b9an6v50ptvr17BEWNUiofi8it
         EwyY8maHcR9WBebCEjfkBv802IRFvg2DbBgGeF3sj6e/+sRTCdWeGvfN7p30d1IetEH8
         LGCA==
X-Forwarded-Encrypted: i=1; AJvYcCVkL1mJ0zPi0MumyTGorz/8lY6DXnZ/tP8NSt4niavuPxJCyiHHzAkDFCFU+T6doGvWgf7cYgzbosnEJTYtYzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqoSH5ymYiowvWeaTdMIRxnPxsl0q3lgJU3gflMF3bKP3jOwzx
	mQxdyRPFwS95IQaZaii5K1eCvq2LdVH/EPq2j+YVi1paRpxOmogAE+imTVYKoUrAQEjgA9puJ2E
	x++Ynl9NVRKDsWsflFbZLzyy4GCasERfNL2kVOR/XQRbLLAs9t03g8OOdHzLSQcYS73c07A==
X-Gm-Gg: ASbGnct60vQrGAJnNZafFmGLKem/paEmsj3i7mPExOI1YYNNwbxo6tzsfiGH0hb73tn
	+3CKJSMbzoXHXOClfMUj/zd2b/zRkFCfXzT5LyKcDPMJv3CgQt6TRjOQKhb3QySFXS28fdo5uxf
	dIFz2rfM4EE/E+JEyVfBgIFNB9+4qmw/qyEzvbF12DJrBQL2W2Vxoye3NPEbhGjGmcrOj3Co5Rf
	0oyj57MiAKjlCPmvpSrlX7i1z7PlNYwyRp30hmg5z4QMtjpdAdsgtPdYZrab+dtlmSo0CN2oTcD
	p3Wavf/pFBIP69DOAp9dYsJ/DdJaex+x93+K6uMr6n9qsBw=
X-Received: by 2002:a05:6402:4303:b0:61c:deac:4693 with SMTP id 4fb4d7f45d1cf-61d269881e0mr14498220a12.12.1756912243657;
        Wed, 03 Sep 2025 08:10:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGPC/zh0tn5QQ7AWeVH9EgPLwkHlr6MfnubUL0ozJ5sOODrP4jLMFrzv67nA8Ss7bZF+LLIQ==
X-Received: by 2002:a05:6402:4303:b0:61c:deac:4693 with SMTP id 4fb4d7f45d1cf-61d269881e0mr14498175a12.12.1756912242981;
        Wed, 03 Sep 2025 08:10:42 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.219.206])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc1c7a10sm12394129a12.5.2025.09.03.08.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 08:10:42 -0700 (PDT)
Date: Wed, 3 Sep 2025 17:10:31 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v5 4/9] vsock/loopback: add netns support
Message-ID: <yuumxtgizcrkn4uspczro76p6u2dqvra5otqkrb57bi2se2lpx@zg4f4rtix7hb>
References: <20250827-vsock-vmtest-v5-0-0ba580bede5b@meta.com>
 <20250827-vsock-vmtest-v5-4-0ba580bede5b@meta.com>
 <mhjgn7fdztfqi6ku3gesgd42jj5atn4sqnvpyncw2jds23dpc3@iiupljayjxs4>
 <aLcy4Kk0joVPbxkd@devvm6216.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aLcy4Kk0joVPbxkd@devvm6216.cco0.facebook.com>

On Tue, Sep 02, 2025 at 11:09:36AM -0700, Bobby Eshleman wrote:
>On Tue, Sep 02, 2025 at 05:39:33PM +0200, Stefano Garzarella wrote:
>> On Wed, Aug 27, 2025 at 05:31:32PM -0700, Bobby Eshleman wrote:
>> > From: Bobby Eshleman <bobbyeshleman@meta.com>
>> >
>> > Add NS support to vsock loopback. Sockets in a global mode netns
>> > communicate with each other, regardless of namespace. Sockets in a local
>> > mode netns may only communicate with other sockets within the same
>> > namespace.
>> >
>> > Add callbacks for transport to hook into the initialization and exit of
>> > net namespaces.
>> >
>> > The transport's init hook will be called once per netns init. Likewise
>> > for exit.
>> >
>> > When a set of init/exit callbacks is registered, the init callback is
>> > called on each already existing namespace.
>> >
>> > Only one callback registration is supported for now. Currently
>> > vsock_loopback is the only user.
>>
>> Why?
>>
>> In general, commit descriptions (and code comments) should focus on the
>> reason (why?) to simplify also the review.
>>
>
>Sounds good, will improve the message/comments. I'm realizing as I type
>this there may be a way to avoid the callbacks altogether with
>pernet_operations, so I'll clarify that before next rev.

Yeah, that would be great.

>
>> >
>> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>> >
>> > ---
>> > Changes in v5:
>> > - add callbacks code to avoid reverse dependency
>> > - add logic for handling vsock_loopback setup for already existing
>> >  namespaces
>> > ---
>> > include/net/af_vsock.h         |  34 +++++++++++++
>> > include/net/netns/vsock.h      |   5 ++
>> > net/vmw_vsock/af_vsock.c       | 110 +++++++++++++++++++++++++++++++++++++++++
>> > net/vmw_vsock/vsock_loopback.c |  72 ++++++++++++++++++++++++---
>> > 4 files changed, 213 insertions(+), 8 deletions(-)
>> >
>> > diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>> > index 83f873174ba3..9333a98b9a1e 100644
>> > --- a/include/net/af_vsock.h
>> > +++ b/include/net/af_vsock.h
>> > @@ -305,4 +305,38 @@ static inline bool vsock_net_check_mode(struct net *n1, struct net *n2)
>> > 	       (vsock_net_mode(n1) == VSOCK_NET_MODE_GLOBAL &&
>> > 		vsock_net_mode(n2) == VSOCK_NET_MODE_GLOBAL);
>> > }
>> > +
>> > +struct vsock_net_callbacks {
>> > +	int (*init)(struct net *net);
>> > +	void (*exit)(struct net *net);
>> > +	struct module *owner;
>> > +};
>> > +
>> > +#if IS_ENABLED(CONFIG_VSOCKETS_LOOPBACK)
>> > +
>> > +#define vsock_register_net_callbacks(__init, __exit) \
>> > +	__vsock_register_net_callbacks((__init), (__exit), THIS_MODULE)
>> > +
>> > +int __vsock_register_net_callbacks(int (*init)(struct net *net),
>> > +				   void (*exit)(struct net *net),
>> > +				   struct module *owner);
>> > +void vsock_unregister_net_callbacks(void);
>> > +
>> > +#else
>> > +
>> > +#define vsock_register_net_callbacks(__init, __exit) do { } while (0)
>> > +
>> > +static inline int __vsock_register_net_callbacks(int (*init)(struct net *net),
>> > +						 void (*exit)(struct net *net),
>> > +						 struct module *owner)
>> > +{
>> > +	return 0;
>> > +}
>> > +
>> > +static inline void vsock_unregister_net_callbacks(void) {}
>> > +static inline int vsock_net_call_init(struct net *net) { return 0; }
>> > +static inline void vsock_net_call_exit(struct net *net) {}
>> > +
>> > +#endif /* CONFIG_VSOCKETS_LOOPBACK */
>> > +
>> > #endif /* __AF_VSOCK_H__ */
>> > diff --git a/include/net/netns/vsock.h b/include/net/netns/vsock.h
>> > index d4593c0b8dc4..08d9a933c540 100644
>> > --- a/include/net/netns/vsock.h
>> > +++ b/include/net/netns/vsock.h
>> > @@ -9,6 +9,8 @@ enum vsock_net_mode {
>> > 	VSOCK_NET_MODE_LOCAL,
>> > };
>> >
>> > +struct vsock_loopback;
>> > +
>> > struct netns_vsock {
>> > 	struct ctl_table_header *vsock_hdr;
>> > 	spinlock_t lock;
>> > @@ -16,5 +18,8 @@ struct netns_vsock {
>> > 	/* protected by lock */
>> > 	enum vsock_net_mode mode;
>> > 	bool written;
>> > +#if IS_ENABLED(CONFIG_VSOCKETS_LOOPBACK)
>> > +	struct vsock_loopback *loopback;
>>
>> If this is not protected by `lock`, please leave an empty line, but maybe we
>> should consider using locking (see comment later).
>>
>
>Will do.
>
>> > +#endif
>> > };
>> > #endif /* __NET_NET_NAMESPACE_VSOCK_H */
>> > diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>> > index 68a8875c8106..5a73d9e1a96f 100644
>> > --- a/net/vmw_vsock/af_vsock.c
>> > +++ b/net/vmw_vsock/af_vsock.c
>> > @@ -134,6 +134,9 @@
>> > #include <uapi/linux/vm_sockets.h>
>> > #include <uapi/asm-generic/ioctls.h>
>> >
>> > +static struct vsock_net_callbacks vsock_net_callbacks;
>> > +static DEFINE_MUTEX(vsock_net_callbacks_lock);
>> > +
>> > static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr);
>> > static void vsock_sk_destruct(struct sock *sk);
>> > static int vsock_queue_rcv_skb(struct sock *sk, struct sk_buff *skb);
>> > @@ -2781,6 +2784,49 @@ static void vsock_net_init(struct net *net)
>> > 	net->vsock.mode = VSOCK_NET_MODE_GLOBAL;
>> > }
>> >
>> > +#if IS_ENABLED(CONFIG_VSOCKETS_LOOPBACK)
>> > +static int vsock_net_call_init(struct net *net)
>> > +{
>> > +	struct vsock_net_callbacks *cbs;
>> > +	int ret;
>> > +
>> > +	mutex_lock(&vsock_net_callbacks_lock);
>> > +	cbs = &vsock_net_callbacks;
>> > +
>> > +	ret = 0;
>> > +	if (!cbs->owner)
>> > +		goto out;
>> > +
>> > +	if (try_module_get(cbs->owner)) {
>> > +		ret = cbs->init(net);
>> > +		module_put(cbs->owner);
>> > +	}
>> > +
>> > +out:
>> > +	mutex_unlock(&vsock_net_callbacks_lock);
>> > +	return ret;
>> > +}
>> > +
>> > +static void vsock_net_call_exit(struct net *net)
>> > +{
>> > +	struct vsock_net_callbacks *cbs;
>> > +
>> > +	mutex_lock(&vsock_net_callbacks_lock);
>> > +	cbs = &vsock_net_callbacks;
>> > +
>> > +	if (!cbs->owner)
>> > +		goto out;
>> > +
>> > +	if (try_module_get(cbs->owner)) {
>> > +		cbs->exit(net);
>> > +		module_put(cbs->owner);
>> > +	}
>> > +
>> > +out:
>> > +	mutex_unlock(&vsock_net_callbacks_lock);
>> > +}
>> > +#endif /* CONFIG_VSOCKETS_LOOPBACK */
>> > +
>> > static __net_init int vsock_sysctl_init_net(struct net *net)
>> > {
>> > 	vsock_net_init(net);
>> > @@ -2788,12 +2834,20 @@ static __net_init int vsock_sysctl_init_net(struct net *net)
>> > 	if (vsock_sysctl_register(net))
>> > 		return -ENOMEM;
>> >
>> > +	if (vsock_net_call_init(net) < 0)
>> > +		goto err_sysctl;
>> > +
>> > 	return 0;
>> > +
>> > +err_sysctl:
>> > +	vsock_sysctl_unregister(net);
>> > +	return -ENOMEM;
>> > }
>> >
>> > static __net_exit void vsock_sysctl_exit_net(struct net *net)
>> > {
>> > 	vsock_sysctl_unregister(net);
>> > +	vsock_net_call_exit(net);
>> > }
>> >
>> > static struct pernet_operations vsock_sysctl_ops __net_initdata = {
>> > @@ -2938,6 +2992,62 @@ void vsock_core_unregister(const struct
>> > vsock_transport *t)
>> > }
>> > EXPORT_SYMBOL_GPL(vsock_core_unregister);
>> >
>> > +#if IS_ENABLED(CONFIG_VSOCKETS_LOOPBACK)
>> > +int __vsock_register_net_callbacks(int (*init)(struct net *net),
>> > +				   void (*exit)(struct net *net),
>> > +				   struct module *owner)
>> > +{
>> > +	struct vsock_net_callbacks *cbs;
>> > +	struct net *net;
>> > +	int ret = 0;
>> > +
>> > +	mutex_lock(&vsock_net_callbacks_lock);
>> > +
>> > +	cbs = &vsock_net_callbacks;
>> > +	cbs->init = init;
>> > +	cbs->exit = exit;
>> > +	cbs->owner = owner;
>> > +
>> > +	/* call callbacks on any net previously created */
>> > +	down_read(&net_rwsem);
>> > +
>> > +	if (try_module_get(cbs->owner)) {
>> > +		for_each_net(net) {
>> > +			ret = cbs->init(net);
>> > +			if (ret < 0)
>> > +				break;
>> > +		}
>> > +
>> > +		if (ret < 0)
>> > +			for_each_net(net)
>> > +				cbs->exit(net);
>> > +
>> > +		module_put(cbs->owner);
>> > +	}
>> > +
>> > +	up_read(&net_rwsem);
>> > +	mutex_unlock(&vsock_net_callbacks_lock);
>> > +
>> > +	return ret;
>> > +}
>> > +EXPORT_SYMBOL_GPL(__vsock_register_net_callbacks);
>> > +
>> > +void vsock_unregister_net_callbacks(void)
>> > +{
>> > +	struct vsock_net_callbacks *cbs;
>> > +
>> > +	mutex_lock(&vsock_net_callbacks_lock);
>> > +
>> > +	cbs = &vsock_net_callbacks;
>> > +	cbs->init = NULL;
>> > +	cbs->exit = NULL;
>> > +	cbs->owner = NULL;
>> > +
>> > +	mutex_unlock(&vsock_net_callbacks_lock);
>> > +}
>> > +EXPORT_SYMBOL_GPL(vsock_unregister_net_callbacks);
>>
>> IIUC this function is called only in the error path of
>> `vsock_loopback_init()`, but shuold we call it also in the
>> vsock_loopback_exit() ?
>>
>
>Ah right, that needs to be done there too.
>
>> > +#endif /* CONFIG_VSOCKETS_LOOPBACK */
>> > +
>> > module_init(vsock_init);
>> > module_exit(vsock_exit);
>> >
>> > diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
>> > index 1b2fab73e0d0..f16d21711cb0 100644
>> > --- a/net/vmw_vsock/vsock_loopback.c
>> > +++ b/net/vmw_vsock/vsock_loopback.c
>> > @@ -28,8 +28,19 @@ static u32 vsock_loopback_get_local_cid(void)
>> >
>> > static int vsock_loopback_send_pkt(struct sk_buff *skb)
>> > {
>> > -	struct vsock_loopback *vsock = &the_vsock_loopback;
>> > +	struct vsock_loopback *vsock;
>> > 	int len = skb->len;
>> > +	struct net *net;
>> > +
>> > +	if (skb->sk)
>> > +		net = sock_net(skb->sk);
>> > +	else
>> > +		net = NULL;
>>
>> Why we can't use `virtio_vsock_skb_net` here?
>>
>
>No reason why not. Using it should make it more uniform.
>
>> > +
>> > +	if (net && net->vsock.mode == VSOCK_NET_MODE_LOCAL)
>> > +		vsock = net->vsock.loopback;
>> > +	else
>> > +		vsock = &the_vsock_loopback;
>> >
>> > 	virtio_vsock_skb_queue_tail(&vsock->pkt_queue, skb);
>> > 	queue_work(vsock->workqueue, &vsock->pkt_work);
>> > @@ -134,27 +145,72 @@ static void vsock_loopback_work(struct work_struct *work)
>> > 	}
>> > }
>> >
>> > -static int __init vsock_loopback_init(void)
>> > +static int vsock_loopback_init_vsock(struct vsock_loopback *vsock)
>> > {
>> > -	struct vsock_loopback *vsock = &the_vsock_loopback;
>> > -	int ret;
>> > -
>> > 	vsock->workqueue = alloc_workqueue("vsock-loopback", 0, 0);
>> > 	if (!vsock->workqueue)
>> > 		return -ENOMEM;
>> >
>> > 	skb_queue_head_init(&vsock->pkt_queue);
>> > 	INIT_WORK(&vsock->pkt_work, vsock_loopback_work);
>> > +	return 0;
>> > +}
>> > +
>> > +static void vsock_loopback_deinit_vsock(struct vsock_loopback *vsock)
>> > +{
>> > +	if (vsock->workqueue)
>> > +		destroy_workqueue(vsock->workqueue);
>> > +}
>> > +
>> > +/* called with vsock_net_callbacks lock held */
>> > +static int vsock_loopback_init_net(struct net *net)
>> > +{
>> > +	if (WARN_ON_ONCE(net->vsock.loopback))
>> > +		return 0;
>> > +
>>
>> Do we need some kind of locking here? I mean when reading/setting
>> `net->vsock.loopback`?
>>
>
>I could be wrong here, but I think net->vsock.loopback being set before
>vsock_core_register() prevents racing with net->vsock.loopback reads. We
>could add a lock to make sure and to make the protection explicit
>though.

I see, talkink about vsock_core_register(), I was thinking about,
extending it, maybe passing a struct with all parameters (e.g. transport
type, net callbacks, etc.). In this way we can easily check if the type
of transport is allowed to register net callbacks or not.

Also because currently we don't do any check in
__vsock_register_net_callbacks() about transport type or even about
overriding calls.

>
>> > +	net->vsock.loopback = kmalloc(sizeof(*net->vsock.loopback),
>> > GFP_KERNEL);
>> > +	if (!net->vsock.loopback)
>> > +		return -ENOMEM;
>> > +
>> > +	return vsock_loopback_init_vsock(net->vsock.loopback);
>> > +}
>> > +
>> > +/* called with vsock_net_callbacks lock held */
>> > +static void vsock_loopback_exit_net(struct net *net)
>> > +{
>> > +	if (net->vsock.loopback) {
>> > +		vsock_loopback_deinit_vsock(net->vsock.loopback);
>> > +		kfree(net->vsock.loopback);
>>
>> Should we set `net->vsock.loopback` to NULL here?
>>
>
>Yes.
>
>> > +	}
>> > +}
>> > +
>> > +static int __init vsock_loopback_init(void)
>> > +{
>> > +	struct vsock_loopback *vsock = &the_vsock_loopback;
>> > +	int ret;
>> > +
>> > +	ret = vsock_loopback_init_vsock(vsock);
>> > +	if (ret < 0)
>> > +		return ret;
>> > +
>> > +	ret = vsock_register_net_callbacks(vsock_loopback_init_net,
>> > +					   vsock_loopback_exit_net);
>>
>> IIUC we need this only here because for now the only other transport
>> supported is vhost-vsock, and IIUC `struct vhost_vsock *` there is handled
>> with a map instead of a static variable, and `net` assigned when
>> /dev/vhost-vsock is opened, right?
>>
>
>Correct. The vhost map lookup is modified to account for namespaces, but
>vsock loopback doesn't have a map to do that. The callbacks are used to
>hook into the netns initialization.
>
>I wonder if it is possible to do this with just pernet_operations
>though... when I wrote this I was pretty laser-focused on the
>sysctl/procfs + netns init code, and may not have realized there may be
>similar hooks that aren't bound to the sysctl/proc init. I'll clarify
>this before the next rev.

I like the idea of removing vsock_register_net_callbacks() if possible,
but if it's not possible I'd like to reuse vsock_core_register() as much
as possible, avoiding to add a new register function that is not clear
when it needs to be called or not by the transport.

So, to be clear, I'd like to have a single registration function that
transports need to call (if possible).

>
>
>> If in the future we will need to support G2H transports, like
>> virtio-transport, we need to do something similar, right?
>>
>
>My guess is that we'll be able to avoid using these callbacks unless
>there is some per-net data we need to initialize. I'm guessing if we
>follow a similar path as using ioctl to assign the dev netns, then we
>won't need it. It might be moot if pernet_operations work to avoid the
>module circular dependency.

Cool!

>
>> BTW I think we really need to exaplin this better in the commit description.
>> It tooks me a while to get all of this (if it's correct)
>>
>
>Roger that, I'll improve this going forward.

Thanks,
Stefano


