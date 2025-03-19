Return-Path: <linux-kselftest+bounces-29471-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C16D7A69CC4
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 00:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8A1F189B7BF
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 23:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6737224232;
	Wed, 19 Mar 2025 23:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QnBImN/V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183FA224225
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Mar 2025 23:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742427389; cv=none; b=njEa4MEB6V6zk+0lm3xGbyqWXpRNDldwu3AWFvCRf3HnMZ2ymSvCPXsNrkKsIRDAXQj7iBYQ2ftu3eyVmsKt5wU015ubaAC7eQ3AAT1nekkFQPEBN+bXSGAdj3Zrigxy+3K1iGnVQKTWveEVrBM/e8eAOo3MsAD54C3Uyw/yxd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742427389; c=relaxed/simple;
	bh=YaRk1s+zKGq0iW53na4lPbKXthAEJqUr5Yf1QKrfQcg=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=oerwYUnLQKPRgJ/fIyI6V2AOMq74BsRwOxdzW2sgu+ZwK8OPMeZkv3I+zIxkdJk+1NA1RIJ3PDj8n7fsJ/qpoIy9alm4H7KVUpQra/+neOhpGT00Uk3ZIw7hhyXePnqWgeFYd643iAqx+bxhLf+hi1hg3U0joom2pkCwhUFElpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QnBImN/V; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742427375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=844+bFvi6TAU7lUIUgTQSz2iWfzhmszHPEf60+qFp+8=;
	b=QnBImN/VO449dDkv3U3QRL7hRSidSmJ8OHba+RK799rWcGmbaMKw2XD/9Oj6KYDCfc4YQr
	FnBO9EhNIaUm63vbjR1/lAtuuh/t3yG6wgq52jwVX+5KSaGysf8LdyzFi6ERlpxo+HotTe
	v5LXpOst8ccObU+5LSs8LqvdmGB6Fvg=
Date: Wed, 19 Mar 2025 23:36:13 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <48068a86ea99dffe1e7849fb544eac1746364afb@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf-next v3 1/3] bpf, sockmap: avoid using sk_socket
 after free when sending
To: "Cong Wang" <xiyou.wangcong@gmail.com>
Cc: john.fastabend@gmail.com, jakub@cloudflare.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com,
 ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 mhal@rbox.co, sgarzare@redhat.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
In-Reply-To: <Z9tNAhMV1Y5znONo@pop-os.localdomain>
References: <20250317092257.68760-1-jiayuan.chen@linux.dev>
 <20250317092257.68760-2-jiayuan.chen@linux.dev>
 <Z9tNAhMV1Y5znONo@pop-os.localdomain>
X-Migadu-Flow: FLOW_OUT

2025/3/20 07:02, "Cong Wang" <xiyou.wangcong@gmail.com> wrote:

>=20
>=20On Mon, Mar 17, 2025 at 05:22:54PM +0800, Jiayuan Chen wrote:
>=20
>=20>=20
>=20> The sk->sk_socket is not locked or referenced, and during the call =
to
> >=20
>=20
> Hm? We should have a reference in socket map, whether directly or
>=20
>=20indirectly, right? When we add a socket to a socket map, we do call
>=20
>=20sock_map_psock_get_checked() to obtain a reference.
>=20

Yes,=20but we remove psock from sockmap when sock_map_close() was called
'''
sock_map_close
	lock_sock(sk);
	rcu_read_lock();
	psock =3D sk_psock(sk);
        // here we remove psock and the reference of psock become 0
	sock_map_remove_links(sk, psock)
        psock =3D sk_psock_get(sk);
        if (unlikely(!psock))
            goto no_psock;     <=3D=3D=3D jmp to no_psock
        rcu_read_unlock();
        release_sock(sk);
        cancel_delayed_work_sync(&psock->work); <=3D=3D no chance to run =
cancel
'''

So I think we should hold the psock when backlog running

Thanks,

