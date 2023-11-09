Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10FE7E68DC
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Nov 2023 11:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbjKIKxB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Nov 2023 05:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbjKIKw6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Nov 2023 05:52:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739F126AF
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Nov 2023 02:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699527128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/fEMZu04vJmPyEDeZ4tFFxfgW3Qd9nS2eGWSB2Vs73s=;
        b=Id6+graJtD4jUxo3awPyoB+LjUj2/IkSyjSLwob4XBj3xzudQTRCjh5NG+oXjuNq3G+GrT
        nEmeAC2GjORp86piU6S074f+QQSz3RxyfK+D/x0sjJNsmHFULI3WuG94Vu0Zw4DRBCWbjs
        00H6Iexk9CBSEKxpG0zkdXJrEIFiigc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-E4ORqiOAPeq5kY8Il6tzAQ-1; Thu, 09 Nov 2023 05:52:07 -0500
X-MC-Unique: E4ORqiOAPeq5kY8Il6tzAQ-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-66cfa898cfeso1039136d6.0
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Nov 2023 02:52:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699527126; x=1700131926;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/fEMZu04vJmPyEDeZ4tFFxfgW3Qd9nS2eGWSB2Vs73s=;
        b=FN3dGNKz7EX1PaTQvyhmKDLp0/bSqYmLrA4jYVBcC/gybRGnrFQ9CexwTgxBRK8QKh
         57Bg/N+NqeTccmL2mpeWQmi3pwb250hB+dfCyKcBUrAuOB1qhgEE+rRRo5TSrc3F5H1c
         ciRO6GbC/Y1NFORSEoJZHHk70nlAQ2ht7v+0rlFiJ5el69tYEMGlQwKZqbDput5F04H2
         E+qW0V7NL1KQRjUIsaO3PfEeaFfUgxtt9xGYBNEFopRzSMqMe1emhqD1fx4pkmvMg1Uh
         FmiKKmtlAxs+JNXYxBGs8JmuGyEQ9/tWzHs4aYpvjpaVpbGnpuZRd6oWXKxbXW5dShDr
         zLbQ==
X-Gm-Message-State: AOJu0Yz8unuFaV7+sMlOx/W9aL/NuqZKzxWm4HGjYyF/bkv/Rwq5i1A8
        J+sPlm7Lslsa2Igjqf+p3PxpIzAFlWqlyjXknECGS/Ah4+SRc0PnVeHn8hoMiR88t4QQTvT60mp
        wBEjXDDwTzgw1wi5wKydZ3wT79n+S
X-Received: by 2002:a05:6214:4a:b0:670:d117:1f9e with SMTP id c10-20020a056214004a00b00670d1171f9emr4487359qvr.2.1699527126642;
        Thu, 09 Nov 2023 02:52:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAk/DQxSd74d4wUNFAZnKsQQezg47K5p4R/fP0LVcZMKk5oMlW4rqzws8VL1bQTjgTMKPmVQ==
X-Received: by 2002:a05:6214:4a:b0:670:d117:1f9e with SMTP id c10-20020a056214004a00b00670d1171f9emr4487333qvr.2.1699527126264;
        Thu, 09 Nov 2023 02:52:06 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-228-197.dyn.eolo.it. [146.241.228.197])
        by smtp.gmail.com with ESMTPSA id l8-20020a056214104800b0065d89f4d537sm1952390qvr.45.2023.11.09.02.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 02:52:05 -0800 (PST)
Message-ID: <e584ca804a2e98bcf6e8e5ea2d4206f9f579e0ce.camel@redhat.com>
Subject: Re: [RFC PATCH v3 10/12] tcp: RX path for devmem TCP
From:   Paolo Abeni <pabeni@redhat.com>
To:     Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Ahern <dsahern@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Kaiyuan Zhang <kaiyuanz@google.com>
Date:   Thu, 09 Nov 2023 11:52:01 +0100
In-Reply-To: <20231106024413.2801438-11-almasrymina@google.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
         <20231106024413.2801438-11-almasrymina@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, 2023-11-05 at 18:44 -0800, Mina Almasry wrote:
[...]
> +/* On error, returns the -errno. On success, returns number of bytes sen=
t to the
> + * user. May not consume all of @remaining_len.
> + */
> +static int tcp_recvmsg_devmem(const struct sock *sk, const struct sk_buf=
f *skb,
> +			      unsigned int offset, struct msghdr *msg,
> +			      int remaining_len)
> +{
> +	struct cmsg_devmem cmsg_devmem =3D { 0 };
> +	unsigned int start;
> +	int i, copy, n;
> +	int sent =3D 0;
> +	int err =3D 0;
> +
> +	do {
> +		start =3D skb_headlen(skb);
> +
> +		if (!skb_frags_not_readable(skb)) {

As 'skb_frags_not_readable()' is intended to be a possibly wider scope
test then skb->devmem, should the above test explicitly skb->devmem?

> +			err =3D -ENODEV;
> +			goto out;
> +		}
> +
> +		/* Copy header. */
> +		copy =3D start - offset;
> +		if (copy > 0) {
> +			copy =3D min(copy, remaining_len);
> +
> +			n =3D copy_to_iter(skb->data + offset, copy,
> +					 &msg->msg_iter);
> +			if (n !=3D copy) {
> +				err =3D -EFAULT;
> +				goto out;
> +			}
> +
> +			offset +=3D copy;
> +			remaining_len -=3D copy;
> +
> +			/* First a cmsg_devmem for # bytes copied to user
> +			 * buffer.
> +			 */
> +			memset(&cmsg_devmem, 0, sizeof(cmsg_devmem));
> +			cmsg_devmem.frag_size =3D copy;
> +			err =3D put_cmsg(msg, SOL_SOCKET, SO_DEVMEM_HEADER,
> +				       sizeof(cmsg_devmem), &cmsg_devmem);
> +			if (err || msg->msg_flags & MSG_CTRUNC) {
> +				msg->msg_flags &=3D ~MSG_CTRUNC;
> +				if (!err)
> +					err =3D -ETOOSMALL;
> +				goto out;
> +			}
> +
> +			sent +=3D copy;
> +
> +			if (remaining_len =3D=3D 0)
> +				goto out;
> +		}
> +
> +		/* after that, send information of devmem pages through a
> +		 * sequence of cmsg
> +		 */
> +		for (i =3D 0; i < skb_shinfo(skb)->nr_frags; i++) {
> +			const skb_frag_t *frag =3D &skb_shinfo(skb)->frags[i];
> +			struct page_pool_iov *ppiov;
> +			u64 frag_offset;
> +			u32 user_token;
> +			int end;
> +
> +			/* skb_frags_not_readable() should indicate that ALL the
> +			 * frags in this skb are unreadable page_pool_iovs.
> +			 * We're checking for that flag above, but also check
> +			 * individual pages here. If the tcp stack is not
> +			 * setting skb->devmem correctly, we still don't want to
> +			 * crash here when accessing pgmap or priv below.
> +			 */
> +			if (!skb_frag_page_pool_iov(frag)) {
> +				net_err_ratelimited("Found non-devmem skb with page_pool_iov");
> +				err =3D -ENODEV;
> +				goto out;
> +			}
> +
> +			ppiov =3D skb_frag_page_pool_iov(frag);
> +			end =3D start + skb_frag_size(frag);
> +			copy =3D end - offset;
> +
> +			if (copy > 0) {
> +				copy =3D min(copy, remaining_len);
> +
> +				frag_offset =3D page_pool_iov_virtual_addr(ppiov) +
> +					      skb_frag_off(frag) + offset -
> +					      start;
> +				cmsg_devmem.frag_offset =3D frag_offset;
> +				cmsg_devmem.frag_size =3D copy;
> +				err =3D xa_alloc((struct xarray *)&sk->sk_user_pages,
> +					       &user_token, frag->bv_page,
> +					       xa_limit_31b, GFP_KERNEL);
> +				if (err)
> +					goto out;
> +
> +				cmsg_devmem.frag_token =3D user_token;
> +
> +				offset +=3D copy;
> +				remaining_len -=3D copy;
> +
> +				err =3D put_cmsg(msg, SOL_SOCKET,
> +					       SO_DEVMEM_OFFSET,
> +					       sizeof(cmsg_devmem),
> +					       &cmsg_devmem);
> +				if (err || msg->msg_flags & MSG_CTRUNC) {
> +					msg->msg_flags &=3D ~MSG_CTRUNC;
> +					xa_erase((struct xarray *)&sk->sk_user_pages,
> +						 user_token);
> +					if (!err)
> +						err =3D -ETOOSMALL;
> +					goto out;
> +				}
> +
> +				page_pool_iov_get_many(ppiov, 1);
> +
> +				sent +=3D copy;
> +
> +				if (remaining_len =3D=3D 0)
> +					goto out;
> +			}
> +			start =3D end;
> +		}
> +
> +		if (!remaining_len)
> +			goto out;
> +
> +		/* if remaining_len is not satisfied yet, we need to go to the
> +		 * next frag in the frag_list to satisfy remaining_len.
> +		 */
> +		skb =3D skb_shinfo(skb)->frag_list ?: skb->next;

I think at this point the 'skb' is still on the sk receive queue. The
above will possibly walk the queue.

Later on, only the current queue tail could be possibly consumed by
tcp_recvmsg_locked(). This feel confusing to me?!? Why don't limit the
loop only the 'current' skb and it's frags?

> +
> +		offset =3D offset - start;
> +	} while (skb);
> +
> +	if (remaining_len) {
> +		err =3D -EFAULT;
> +		goto out;
> +	}
> +
> +out:
> +	if (!sent)
> +		sent =3D err;
> +
> +	return sent;
> +}
> +
>  /*
>   *	This routine copies from a sock struct into the user buffer.
>   *
> @@ -2314,6 +2463,7 @@ static int tcp_recvmsg_locked(struct sock *sk, stru=
ct msghdr *msg, size_t len,
>  			      int *cmsg_flags)
>  {
>  	struct tcp_sock *tp =3D tcp_sk(sk);
> +	int last_copied_devmem =3D -1; /* uninitialized */
>  	int copied =3D 0;
>  	u32 peek_seq;
>  	u32 *seq;
> @@ -2491,15 +2641,44 @@ static int tcp_recvmsg_locked(struct sock *sk, st=
ruct msghdr *msg, size_t len,
>  		}
> =20
>  		if (!(flags & MSG_TRUNC)) {
> -			err =3D skb_copy_datagram_msg(skb, offset, msg, used);
> -			if (err) {
> -				/* Exception. Bailout! */
> -				if (!copied)
> -					copied =3D -EFAULT;
> +			if (last_copied_devmem !=3D -1 &&
> +			    last_copied_devmem !=3D skb->devmem)
>  				break;
> +
> +			if (!skb->devmem) {
> +				err =3D skb_copy_datagram_msg(skb, offset, msg,
> +							    used);
> +				if (err) {
> +					/* Exception. Bailout! */
> +					if (!copied)
> +						copied =3D -EFAULT;
> +					break;
> +				}
> +			} else {
> +				if (!(flags & MSG_SOCK_DEVMEM)) {
> +					/* skb->devmem skbs can only be received
> +					 * with the MSG_SOCK_DEVMEM flag.
> +					 */
> +					if (!copied)
> +						copied =3D -EFAULT;
> +
> +					break;
> +				}
> +
> +				err =3D tcp_recvmsg_devmem(sk, skb, offset, msg,
> +							 used);
> +				if (err <=3D 0) {
> +					if (!copied)
> +						copied =3D -EFAULT;
> +
> +					break;
> +				}
> +				used =3D err;

Minor nit: I personally would find the above more readable, placing
this whole chunk in a single helper (e.g. the current
tcp_recvmsg_devmem(), renamed to something more appropriate).

Cheers,

Paolo

