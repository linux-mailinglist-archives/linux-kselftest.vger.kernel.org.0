Return-Path: <linux-kselftest+bounces-49430-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC4FD3BD52
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 02:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DFB9306EADF
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 01:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3035125A645;
	Tue, 20 Jan 2026 01:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jo9LFTYc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45053260565
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Jan 2026 01:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768874084; cv=pass; b=ZNEmI2+UPhAVqSZ1bNWqTsp/Yw5Cmjf3HOpExuObBivLD+LY+mJO5KVx+pDDCJRqDJfgZfJiBNYsMLqpL6ypxDDe6f78bemVFjt2eU0wDjHsVIpw6w6QVPFJJH6UKXfobZNxhHtq5ixf7PyuINGObF9v9akqnL/bnFRoT0dC9pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768874084; c=relaxed/simple;
	bh=XGnx+hJEeSArfiv7aLN3NyUqUkXPRFZ7Ia+4ttpmkFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=alNU91csmoyk3rHtNnGfc+Z32K+fQY5acYCre6fAknr8EsHY3luGEf5XuXHjtesQaMW3d/VhjujiqlviHsLsRsdovC4kVKa84XlFSz4SFsxt5j6Dyoimbu1HZ8lrE3c0Mvn20OQ0OGU+/vSHt03ehpwC500c1OVgdIqHW2JpMQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jo9LFTYc; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4801c1ad878so36879615e9.1
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Jan 2026 17:54:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768874078; cv=none;
        d=google.com; s=arc-20240605;
        b=WPBvjkmy14NrgBpPJUGkaCX6/shEb7+fQJiJX9blIM0Z6DU00wwbtsgUDhRHoI3Tnb
         xADa/KTEROJ/rIxv9BHgDeFjDmpWIOL1K+ssNdEvNrl+Say6zlU+U7FthwwqPgba9YhR
         zQs2J0OFxCa+25GtyOCQDgXJQmWokyEU+hc3zaVcV9rKlHXq2CALmxmsTefDDQnlvv17
         6PYUk04lizLWIx7beq6t6XllBV/lzJgvARc7hr8I36fvvGBzbEsmV6ZKqenieMiOJOGR
         ihfFd5sDBZOuUFrz3ugtC4HInfSCTpTrAdhDjYkyJrgTo3YqBUej8n+4SMWdNRtU3b3E
         +YvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xv9zEHuRc9c1EY5SUHsPnAlQlZPm41qdCAYpBSnMb3A=;
        fh=zFenITEO0SVDjH8Df9e7Cq/bkziFKZnOMF6DZFJ5hsQ=;
        b=PdhefEHwp/euQAxEh8TRRasOqgLt+7d1b8Rn0wu5Bsj7tAPHpNTYYcKihE01SRpkmc
         hQvUPnoti82zt0M/uNpNKVvrO0vRKcS9AodMeU8RguQyRmBNs7I2T+p+TFk4dICzcyDX
         ZE8oytejpEiSVEHnh9lttKg61EGr4lmSMSKIfAFgeCZqKjkK5xTbZOigBTnCzkY4QUkr
         FCCXMr76oxQS+iFYd8iJpPCOb08xcu/n+Ds8bLi8uV+QE5q2REOGeNPYvLdGUGETsjcb
         2QXw7fqX7iiFYJMf61WX3M20yCBTr4bGPzOrtYuh5pMtxbBQqV74iTElV9twqxbp5e5C
         xPKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768874078; x=1769478878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xv9zEHuRc9c1EY5SUHsPnAlQlZPm41qdCAYpBSnMb3A=;
        b=Jo9LFTYct/5buioDVaVlin68/jmGh38Ec3ZdrjaDEMpUl4LWGopPQhttolGraoBdml
         MbieNdllTlPWO4/6A1Zn1awOHrTsaZoZU3r6qavyv6tI54L2kFBRza5qE7bTidCVYa8l
         8B53P0lFMs4JCHlnUMcWmLWaQZ00XkA/vJYTnU0OfTEDJWRfK1mqlsjgz2CoZIZRSwv2
         mOvkHLR26yI6iDbbp52Doa9Jz2uW8IkdagA4VbnP9kAq6FfL8ZM+r8TYxLrG5kEZhJ+8
         t5ZetrKTb/7Jf7X9fq22D/PQ3f7rKdd3T2r7fWxs7Loj3pM8lvfK+Xw4AfEuYMG9UkW2
         HwMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768874078; x=1769478878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xv9zEHuRc9c1EY5SUHsPnAlQlZPm41qdCAYpBSnMb3A=;
        b=TbOurzzBVzJNTsYl8MB96gTItI9b7jXwLNvFbBIx8w8Mxr7ecZRxfRCQWCqJDpziSG
         0hyWFKLpIGYlhTblkHlj1MpESnFwgM4Uw2HCqOci/JgM/Xt+fh87R/64jmA43ALLNOZi
         WHimNsmVmMBpwxPxu2LZ2tpOCFYkWwf2lIpM38CE212Y1BpW7sFuLd9iH7qIhJcD3An7
         /hXanZ+kLxSlUpJKYFIKKZKSahdNzlt3IhiztAfFFEWhUYy8agRkU5r5FTDvYTzhqTVC
         QSLLWcI6aWg0JnAuZpFM1cNkvCk68Lds0pIDT2ZCyLtEFmSW5weL7pWZ3vBh0hFaBWSX
         xBBA==
X-Forwarded-Encrypted: i=1; AJvYcCUcRT2Sz4tYP/tmoR+v3ExcJAc8B60wR3uciRKkDZ6usspJS+O4z0u9O/v9GpZ+rYu2QXEeoCWjS8Nxxn6vC/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkecbJbLhZ22hpi2NENa/PeO6o6PiGsuUiP5LZIsoKAot8rF5V
	mqekhpxC49zUynzBE1a2/Ha92ULcr04Ox7s8sL9XXT1mMhuCOGUVvoI5j9ZTL3MGE9EM44ivyUc
	spcRUB5Ebjp277+vm470RhmYWrbIE9A0=
X-Gm-Gg: AY/fxX5OqYJFUgaJCDa0az/ygDoWeyS/1IoP/29udu/NQ4PvX3LsZBe9wjsDQJEmY6y
	GGbJPV6L7/5To/lQcUcxqkSBQ5CPvWbVn9AcsMtYqYaH1MaQoX/NzPWaqsIyxIDf8A2bQX7eKMC
	yYOzp4Fp5pnBVYlobW+CRgmORFMl8UMSL+g0RDMux9Z/v5rXUqpWbdI46dGG9RIqVNke58ERUpb
	fCOAhj0hQUR0Cw1ACS3y4DspuqIzgBZnhMlwUAe362kBGBKR7+pYnv8+MpXjJ/OFKAqCb5N4QO3
	xvlZt3gCMXg9gbOAN6H+zRAGRmJLxcQiYLZKvEBNI7oXY9fymMYKjstyLSdkz7WWZnDjaDjvLmQ
	T4VD+GfhJx3ntoloRgSxxU/jp
X-Received: by 2002:a05:600c:1990:b0:475:e09c:960e with SMTP id
 5b1f17b1804b1-4803e7f3d7bmr2343295e9.32.1768874077525; Mon, 19 Jan 2026
 17:54:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119142120.28170-1-leon.hwang@linux.dev> <20260119142120.28170-3-leon.hwang@linux.dev>
 <d4b8843b-c5dc-4468-996a-bacc2db63f11@iogearbox.net> <123a63a2-5679-4bd0-9e16-dc5c7dbe3325@linux.dev>
In-Reply-To: <123a63a2-5679-4bd0-9e16-dc5c7dbe3325@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 19 Jan 2026 17:54:26 -0800
X-Gm-Features: AZwV_QgI1vOqbUDCv84FRy90-_qhDpN6djDh15KMF_24bczedT3fPOgBKU_LWFI
Message-ID: <CAADnVQKdHBe2yLgEvVEddgSbgTVvdzK0iC=vzrif5q_FLLTY-A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: Avoid deadlock using trylock when
 popping LRU free nodes
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kernel-patches-bot@fb.com, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 5:50=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
>
>
> On 20/1/26 03:47, Daniel Borkmann wrote:
> > On 1/19/26 3:21 PM, Leon Hwang wrote:
> >> Switch the free-node pop paths to raw_spin_trylock*() to avoid blockin=
g
> >> on contended LRU locks.
> >>
> >> If the global or per-CPU LRU lock is unavailable, refuse to refill the
> >> local free list and return NULL instead. This allows callers to back
> >> off safely rather than blocking or re-entering the same lock context.
> >>
> >> This change avoids lockdep warnings and potential deadlocks caused by
> >> re-entrant LRU lock acquisition from NMI context, as shown below:
> >>
> >> [  418.260323] bpf_testmod: oh no, recursing into test_1,
> >> recursion_misses 1
> >> [  424.982207] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> [  424.982216] WARNING: inconsistent lock state
> >> [  424.982223] inconsistent {INITIAL USE} -> {IN-NMI} usage.
> >> [  424.982314]  *** DEADLOCK ***
> >> [...]
> >>
> >> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> >> ---
> >>   kernel/bpf/bpf_lru_list.c | 17 ++++++++++-------
> >>   1 file changed, 10 insertions(+), 7 deletions(-)
> >
> > Documentation/bpf/map_lru_hash_update.dot needs update?
> >
>
> Yes, it needs update.
>
> >> diff --git a/kernel/bpf/bpf_lru_list.c b/kernel/bpf/bpf_lru_list.c
> >> index c091f3232cc5..03d37f72731a 100644
> >> --- a/kernel/bpf/bpf_lru_list.c
> >> +++ b/kernel/bpf/bpf_lru_list.c
> >> @@ -312,14 +312,15 @@ static void bpf_lru_list_push_free(struct
> >> bpf_lru_list *l,
> >>       raw_spin_unlock_irqrestore(&l->lock, flags);
> >>   }
> >>   -static void bpf_lru_list_pop_free_to_local(struct bpf_lru *lru,
> >> +static bool bpf_lru_list_pop_free_to_local(struct bpf_lru *lru,
> >>                          struct bpf_lru_locallist *loc_l)
> >>   {
> >>       struct bpf_lru_list *l =3D &lru->common_lru.lru_list;
> >>       struct bpf_lru_node *node, *tmp_node;
> >>       unsigned int nfree =3D 0;
> >>   -    raw_spin_lock(&l->lock);
> >> +    if (!raw_spin_trylock(&l->lock))
> >> +        return false;
> >>
> >
> > Could you provide some more analysis, and the effect this has on real-w=
orld
> > programs? Presumably they'll unexpectedly encounter a lot more frequent
> > -ENOMEM as an error on bpf_map_update_elem even though memory might be
> > available just that locks are contended?
> >
> > Also, have you considered rqspinlock as a potential candidate to discov=
er
> > deadlocks?
>
> Thanks for the questions.
>
> While I haven=E2=80=99t encountered this issue in production systems myse=
lf, the
> deadlock has been observed repeatedly in practice, including the cases
> shown in the cover letter. It can also be reproduced reliably when
> running the LRU tests locally, so this is a real and recurring problem.
>
> I agree that returning -ENOMEM when locks are contended is not ideal.
> Using -EBUSY would better reflect the situation where memory is
> available but forward progress is temporarily blocked by lock
> contention. I can update the patch accordingly.
>
> Regarding rqspinlock: as mentioned in the cover letter, Menglong
> previously explored using rqspinlock to address these deadlocks but was
> unable to arrive at a complete solution. After further off-list
> discussion, we agreed that using trylock is a more practical approach
> here. In most observed cases, the lock contention leading to deadlock
> occurs in bpf_common_lru_pop_free(), and trylock allows callers to back
> off safely rather than risking re-entrancy and deadlock.

Sorry, trylock is not an option here.

We are not going to sacrifice LRU map reliability for the sake of syzbot.

