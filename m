Return-Path: <linux-kselftest+bounces-668-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8097C7FAC96
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 22:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3479B281B94
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 21:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F41A46455;
	Mon, 27 Nov 2023 21:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mypgcsMM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5E7131;
	Mon, 27 Nov 2023 13:32:39 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a0bdf4eeb46so312673066b.3;
        Mon, 27 Nov 2023 13:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701120758; x=1701725558; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W/1uSzXDfGGBJQhktgQcNYFDx6Quw5SgU4SWdrjub/w=;
        b=mypgcsMMNggtuV9bW2/YnBKFa7upRp8gWnNMYqJwu0p6+UOuuv6BnTBFcNdW1zBLsc
         ZIqWj3tESlJeGVfwZfSp1H0r1U3Csqp1M84sikaQ80RKZLTagy1vftXeoi7ljIdfBqgU
         yxAMsPEzL3pFHRsTF+6Xgs4Mlzm79SJgYo9aQFYdnaenaXjaHi2w+uRRiwEctpZUVTUK
         HdzmRfPswq2XmKHTDDTMCji24snRwp9E0XhjXeaJhVXmape+BusMYSP/wXBOry0qLOgx
         fYPLY5AsLzoVezZPlnPXfI7hlNM5JjzUiFIQUc+n7StMZmpqy4V2BDLTabJrjb88lfX+
         r7SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701120758; x=1701725558;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W/1uSzXDfGGBJQhktgQcNYFDx6Quw5SgU4SWdrjub/w=;
        b=FeKMbURmP9juaeuHq0t0fEWjiF0Nm9jbhPxoekZ6BNqVHlFthm81gtgcZf0v2VTvme
         KH4s4CMI7JY9CLkD/fqaKcHgiUVUF8giQ2Go2Ez52I2ikHf3WzCysYj/42UI/EZKEbit
         ZyDWrdjW0/qtT0hm7XiDgY0vm3dlSotwRfXY9/zR5OEB3imFnThbPU4DrZoYvPVckt6w
         Wbipbmd5QmDDex8LZE7CW+ULQhxz0ZFiKkNaMBBpWAycw621WrUc7cdAJKZbYOO4nin6
         ONn//Z/RlnOatqkpmK8VEDeH0MPd9kJ8qVrkK4IUvI7Xhp+igGGuixGyPmlguZj0ROr7
         6EIw==
X-Gm-Message-State: AOJu0YxxKf+DjolOaxx8PwG/qKkv7HODA1Zuj0AmrLBhFnSaWOMCNlwL
	2NlmzPJcvckF/v3DLps82hw=
X-Google-Smtp-Source: AGHT+IGiLRdPfMRCVg9ZEFSpMdpp/TzdZZxtg0wo3DlOFoWnGAfTT/GaVGLjZGSYXUHwDj1D6qqoJA==
X-Received: by 2002:a17:906:4e81:b0:a0e:3a22:af5 with SMTP id v1-20020a1709064e8100b00a0e3a220af5mr1303801eju.77.1701120757825;
        Mon, 27 Nov 2023 13:32:37 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id 3-20020a170906018300b00a0a8b2b74ddsm4087917ejb.154.2023.11.27.13.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 13:32:37 -0800 (PST)
Message-ID: <f4777af7e0b47b41760da5f291a7535c7006adf9.camel@gmail.com>
Subject: Re: [PATCH ipsec-next v1 6/7] bpf: selftests: test_tunnel: Disable
 CO-RE relocations
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Xu <dxu@dxuuu.xyz>, Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Shuah Khan
 <shuah@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Steffen Klassert
 <steffen.klassert@secunet.com>, antony.antony@secunet.com, Mykola Lysenko
 <mykolal@fb.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, John Fastabend <john.fastabend@gmail.com>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, bpf
 <bpf@vger.kernel.org>,  "open list:KERNEL SELFTEST FRAMEWORK"
 <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
 devel@linux-ipsec.org, Network Development <netdev@vger.kernel.org>
Date: Mon, 27 Nov 2023 23:32:35 +0200
In-Reply-To: <xehp2qvy5cyaairbnfhem4hvbsl26blo4zzu7z6ywbp26jcwyn@hgp3v2q4ud7o>
References: <cover.1700676682.git.dxu@dxuuu.xyz>
	 <391d524c496acc97a8801d8bea80976f58485810.1700676682.git.dxu@dxuuu.xyz>
	 <0f210cef-c6e9-41c1-9ba8-225f046435e5@linux.dev>
	 <CAADnVQ+sEsUyNYPeZyOf2PcCnxOvOqw4bUuAuMofCU14szTGvg@mail.gmail.com>
	 <3ec6c068-7f95-419a-a0ae-a901f95e4838@linux.dev>
	 <18e43cdf65e7ba0d8f6912364fbc5b08a6928b35.camel@gmail.com>
	 <uc5fv3keghefszuvono7aclgtjtgjnnia3i54ynejmyrs42ser@bwdpq5gmuvub>
	 <0535eb913f1a0c2d3c291478fde07e0aa2b333f1.camel@gmail.com>
	 <42f9bf0d-695a-412d-bea5-cb7036fa7418@linux.dev>
	 <a5a84482-13ef-47d8-bf07-8017060a5d64@linux.dev>
	 <xehp2qvy5cyaairbnfhem4hvbsl26blo4zzu7z6ywbp26jcwyn@hgp3v2q4ud7o>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-11-27 at 14:45 -0600, Daniel Xu wrote:
[...]
> IIUC uapi structs look the same in BTF as any other struct.

Yes, and all share preserve_access_index attribute because of the way
attribute push/pop directives are generated in vmlinux.h.

> Just wondering, though: will bpftool be able to generate the appropriate
> annotations for uapi structs?=20

The problem is that there is no easy way to identify if structure is
uapi in DWARF (from which BTF is generated).
One way to do this:
- modify pahole to check DW_AT_decl_file for each struct DWARF entry
  and generate some special decl tag in BTF;
- modify bpftool to interpret this tag as a marker to not generate
  preserve_access_index for a structure.

The drawback is that such behavior hardcodes some kernel specific
assumptions both in pahole and in bpftool. It also remains to be seen
if DW_AT_decl_file tags are consistent.

It might be the case that allowing excessive CO-RE relocations is a
better option. (And maybe tweak something about bitfield access
generation to avoid such issues as in this thread).

Thanks,
Eduard

