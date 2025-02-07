Return-Path: <linux-kselftest+bounces-25959-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59741A2BA0D
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 05:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 885113A6719
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 04:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304F1232368;
	Fri,  7 Feb 2025 04:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="WWadQTTu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460C4231CB0
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Feb 2025 04:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738901560; cv=none; b=P33hsgeGMXaZX0tcD8jyRceK7T8A3w14RezzsDUbwGRBbavEIyX4tYnpa6IvkYbxtTEK+3xWNWCYgEekBbC8EejvKeNGkdSxRc1z5H+CEyy7sUSoECjGZMdToSJ3cHA1rRzE2Bza1FZLJ/AnyFxYKFUec2f6OfVRnCj01Cl5q5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738901560; c=relaxed/simple;
	bh=ljH7Na1CjKFmZ9WKQeQ3cW1kEi3W80vBZcOQYMb3Cug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gghoKRqoGB6SQxkzT6mP/54oVVMWO3D1pPJ5piRLsQeH+v0HNWUJHX2d63xvvixaNfI03856zDCbDk1L0b1sM5sQ+jTgodgZPwTv5SJVDjshm9fkvIPDKbtA6OFQrRGaKL6PzXeOCu4yOeT6wsk4KX2PZKBjOJ3sk6YIFJV5iJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=WWadQTTu; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaedd529ba1so213663266b.1
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Feb 2025 20:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1738901556; x=1739506356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PfKeNd5YsT4IdLY3wC4IJkumtp1al9zTd0Fhjp7u0qk=;
        b=WWadQTTuWKonMg+YWigynolMhGVCClf0b8wXsAavP85s6hzYphW+UPRcyhU1QFLUgq
         2StENoPcal6yBlLhv8brdcj2ek2esQM68qizNaRQYoh4eeGgF4MULInBx4mTbLJgy4lG
         R9pVQkIqSzvvvHjocTH2fhsyNKyldq1FwI9vwIZHqZPnPpaHDDMATfPa6lgMr+jkqC8r
         OkYpr7ia0zXExGujWOV9J+OwE32TF+Op8hLZfxV8fV+sqAzoOqdOkGuN0JWrQN2/1oVD
         Luj4HP2PxwcUDoEUDeqUBihNUjtAa3k5uamvuNSwv59UW29nE/jWgU7qPbR8JvTXQvIJ
         3FvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738901556; x=1739506356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PfKeNd5YsT4IdLY3wC4IJkumtp1al9zTd0Fhjp7u0qk=;
        b=QS8oZxNWUziNHsTx1hbSeNyp6pQTd8D3XBNLXymjdjf6JuWlTxzlYUztLxMoma8alr
         umWppITdtjcps5WGm3ABJzkVNftb4MVc/ggz4aA1vRgNoN2I1FFC1GRHZu1FncSEQh2t
         +RnVJhyzduKtWfM0G3vBzLR5JZKZLRzkF3UllWiPkof9A/y/R+oPtvKGWij+A8mfUZ4E
         ip3FFAgieUytCSOwYdREYY8n/Z/NdCRMkiRtbptfMpKnxDtqCEFdYtFPbS5ElkvBStxe
         Bg11XZdY1XnqDRdFjEd/u35W17Z7eEkG7SP8V8w0WfzuPGqM8F/HMepyzk48WWYfRXnc
         cTSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtPcWEP+T/lryDY/KzABrJ1M0lClvB7q9r8rzmoCgUEHTF0K6HXvbEsYjX//FNExpepa2crjKUodcJlgBVV+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrBS7aa/fkSsKWKgr6IgHg6/ZpT7uVUhmSFkis4srzWMLt6F7r
	Fn8JNow0WBzQe+F/d0ifUSjDaApHy/Qkta3z6DuJn7IdjWDF83HeK4oFxp8Wy5a7QPg0N3S4nM0
	FKMC+SjeqF0pMQougN5yphfXl1MQjcB6BFgCS9g==
X-Gm-Gg: ASbGncudl9zQr+DqXZlug15zeyzkGccVq8Juvql60EH+nuxEy7gbB7rCOT+AT3kB6Pp
	By5b1QrXXOY3OxnMyaXzuuVBh4gOlOTCFGEfGDD2QW33HG61FSxq++8D3ia6CjINdmmkvnWYDcg
	Ac0OlN/ItgtOQhJX0=
X-Google-Smtp-Source: AGHT+IF+Dr5Nq2mH34Odbm2J6M0KJZHkh2UhWnVHf00IT85KBVmDwpzVa2YALsjOafjhhAQObIf2PDcukGPveI5Ezxg=
X-Received: by 2002:a05:6402:208a:b0:5dc:5a51:cbfa with SMTP id
 4fb4d7f45d1cf-5de44fe949emr4939486a12.6.1738901556568; Thu, 06 Feb 2025
 20:12:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z6OYbS4WqQnmzi2z@debian.debian> <5f6610a1-3cd0-764e-0f49-91af1004ea50@huaweicloud.com>
 <CAO3-PbrGR-U0+TxgeUUZHSwvNw2Dx=o6_EYf60ND7BLiLA-xWQ@mail.gmail.com>
In-Reply-To: <CAO3-PbrGR-U0+TxgeUUZHSwvNw2Dx=o6_EYf60ND7BLiLA-xWQ@mail.gmail.com>
From: Yan Zhai <yan@cloudflare.com>
Date: Thu, 6 Feb 2025 22:12:25 -0600
X-Gm-Features: AWEUYZkk5n3m-qzxQp53kd6ix3x2ANE2POQRC5vHVyak4SJ0fxlTXB7Q5H7kjkk
Message-ID: <CAO3-PbqOFMMzcy9VBLaTtvihnuCJ2u38RMPnYNPckjF8BzdDkQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: skip non existing key in generic_map_lookup_batch
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, Brian Vazquez <brianvv@google.com>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 2:20=E2=80=AFAM Yan Zhai <yan@cloudflare.com> wrote:
>
> On Thu, Feb 6, 2025 at 12:40=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> =
wrote:
> >
> >
> >
> > Yes, the retry logic doesn't change the previous key. Thanks for the
> > clarifying.
> > > And by "skipping to the next key", it's simply
> > >
> > >   if (err =3D=3D -ENOENT)
> > >        goto next_key;
> > >
> > > Note the "next_key" label was not in the current codebase. It is only
> > > in my posted patch. I don't think this would break lpm_trie unless I
> > > missed something.
> >
> > I was trying to say that the proposed patch may break the lookup_batch
> > operation for lpm_trie, and let me explain step by step:
> >
> > For LPM trie map:
> > (1) ->map_get_next_key(map, prev_key, key) returns a valid key
> >
> > (2) bpf_map_copy_value() return -ENOMENT
> > It means the key must be deleted concurrently.
> >
>
> I see what you mean now, thanks for the detailed explanation!
>
> So for lpm_trie, if an element is deleted between get_next_key and
> copy_value, then retry would still proceed to its next tree node. But
> with or without retry, I think we cannot prevent the key from cycling
> back to the beginning: an element can be deleted after copy_value, so
> the key becomes invalid. After swap with prev_key and call
> bpf_get_next_key, it cycles back to the leftmost. Similar can happen
> if during retry the prev_key also gets invalidated. IIUC the rcu
> locking in lookup really cannot prevent the tree structure from
> changes.
>
> On the other hand, bpf_map_get_next_key manual already specifies "If a
> key is not found, the operation returns zero and sets the next_key
> pointer to the key of the first element.". IMHO it probably makes more
> sense that, regardless of normal or batch lookup, it is ultimately the
> user's responsibility to properly synchronize, or deduplicate what is
> returned from the kernel. I intend to keep the "skip to next" to save
> the unnecessary complexity here, unless there are strong objections
> that I should not.

Thought about this again. It is interesting that hashmap batch lookup
actually guarantees no duplicate in output today. If we want to
achieve the same for lpm_trie, it should have its own batch lookup
routine, which could properly lock the trie against mutation. For the
generic batch, it is still better to be simple. Let me put this in the
V2 patchset for discussion.

best
Yan

>
> > (3) goto next_key
> > It swaps the prev_key and key
> >
> > (4) ->map_get_next_key(map, prev_key, key) again
> > prev_key points to a non-existing key, for LPM trie it will treat just
> > like prev_key=3DNULL case, the returned key will be duplicated.
> >

