Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5E575861F
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 22:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjGRUeW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 16:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGRUeV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 16:34:21 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741C9BD;
        Tue, 18 Jul 2023 13:34:20 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b6f0508f54so93616581fa.3;
        Tue, 18 Jul 2023 13:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689712459; x=1692304459;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6uIhwmFyPqgKxliIJt//d2T340hpaSfqqaiFESvOnJ4=;
        b=V84qZpRKUFedgVV6NSIfUrcUQzjvlHCJ5Q6qzpT0f7lwMxTTPDtVBY6zEkslNsCOgM
         MehMK4K4cljq/GW0G/e0D8lGv6AhbRitlKqo+ySUrDThDBGcSsmzuFUqOR5sKGVn/L7G
         MNq8B82sGdFiuQWRF73NjIACxzyhJMl+Jizx/gzNqPgt/ljgXM6pngtfZM//9ojOQpQ1
         0BnePEl0DIUvYDrguMVPs6iZl3yvlhQO8u/k3zE1Oru/ZJl53djukY5YvVm8/0VXY+Kj
         Y3/orLTWlSBHp8AKhYpiayCAx00KOif0WZsDw1bZOAWWLAUboOl2vVjDe90HZRpg9pv2
         ytUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689712459; x=1692304459;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6uIhwmFyPqgKxliIJt//d2T340hpaSfqqaiFESvOnJ4=;
        b=emIiICL2rnvv67vM2SDdxRCgaBVqUwzjIOQx32lKhWLIDW5rcEEuClcLH/l2hMdvDr
         3iHjMmTfauxHka8YrBgFtFbAXPQB7719WwCvA2ajR9eQzZjSti9w5Ozd7xpRX/Qr9nPb
         CtjZqDkuopZtpVjLZUkld+8/RbszvcIe6ks7/aIb2/dPWApHdFVQ9pkENyREIb3J7Shb
         sbZlQvBZaQjdRJtD8dAB8ahC4VyxEPCPtRguiV0f61a+wtME4GDFKkwPgwyxPmGkFNE6
         G+p+pTc20G+jaHfBatVidvSs4WBUF9RCdvC+rOlPDgEtseyFtg3sF0Kc/E/iYC1NRJAY
         b/gw==
X-Gm-Message-State: ABy/qLYL/xHQDnog/mfvW8OQONMBXLrxLLnw+PDE56FhHsBIDIOygY80
        gNbi4L/P/mJeG9Ch086IOVitnmXSa5WsZgSC5m4=
X-Google-Smtp-Source: APBJJlFAzUmlSYMknfGdgDNc4OKhK+B1hNbXYuatV+BAmsrsmx3KCKRyIw3g2mRNAgzWq0FSSYVd0+QUQyuFzIrGugw=
X-Received: by 2002:a05:651c:106:b0:2b6:c236:b040 with SMTP id
 a6-20020a05651c010600b002b6c236b040mr10893461ljb.12.1689712458314; Tue, 18
 Jul 2023 13:34:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230502005218.3627530-1-drosen@google.com> <20230718082615.08448806@kernel.org>
 <CAADnVQJEEF=nqxo6jHKK=Tn3M_NVXHQjhY=_sry=tE8X4ss25A@mail.gmail.com>
 <20230718090632.4590bae3@kernel.org> <CAADnVQ+4aehGYPJ2qT_HWWXmOSo4WXf69N=N9-dpzERKfzuSzQ@mail.gmail.com>
 <20230718101841.146efae0@kernel.org> <CAADnVQ+jAo4V-Pa9_LhJEwG0QquL-Ld5S99v3LNUtgkiiYwfzw@mail.gmail.com>
 <20230718111101.57b1d411@kernel.org>
In-Reply-To: <20230718111101.57b1d411@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 18 Jul 2023 13:34:06 -0700
Message-ID: <CAADnVQLJBiB7pWDTDNgQW_an+YoB61xkNEsa5g8p6zTy-mAG7Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] bpf: Allow NULL buffers in bpf_dynptr_slice(_rw)
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Daniel Rosenberg <drosen@google.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: multipart/mixed; boundary="000000000000d9ce8c0600c8d6c1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--000000000000d9ce8c0600c8d6c1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 18, 2023 at 11:11=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Tue, 18 Jul 2023 10:50:14 -0700 Alexei Starovoitov wrote:
> > On Tue, Jul 18, 2023 at 10:18=E2=80=AFAM Jakub Kicinski <kuba@kernel.or=
g> wrote:
> > > > you're still missing the point. Pls read the whole patch series.
> > >
> > > Could you just tell me what the point is then? The "series" is one
> > > patch plus some tiny selftests. I don't see any documentation for
> > > how dynptrs are supposed to work either.
> > >
> > > As far as I can grasp this makes the "copy buffer" optional from
> > > the kfunc-API perspective (of bpf_dynptr_slice()).
> > >
> > > > It is _not_ input validation.
> > > > skb_copy_bits is a slow path. One extra check doesn't affect
> > > > performance at all. So 'fast paths' isn't a valid argument here.
> > > > The code is reusing
> > > >         if (likely(hlen - offset >=3D len))
> > > >                 return (void *)data + offset;
> > > > which _is_ the fast path.
> > > >
> > > > What you're requesting is to copy paste
> > > > the whole __skb_header_pointer into __skb_header_pointer2.
> > > > Makes no sense.
> > >
> > > No, Alexei, the whole point of skb_header_pointer() is to pass
> > > the secondary buffer, to make header parsing dependable.
> >
> > of course. No one argues about that.
> >
> > > Passing NULL buffer to skb_header_pointer() is absolutely nonsensical=
.
> >
> > Quick grep through the code proves you wrong:
> > drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > __skb_header_pointer(NULL, start, sizeof(*hp), skb->data,
> >                      skb_headlen(skb), NULL);
> >
> > was done before this patch. It's using __ variant on purpose
> > and explicitly passing skb=3D=3DNULL to exactly trigger that line
> > to deliberately avoid the slow path.
> >
> > Another example:
> > drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> > skb_header_pointer(skb, 0, 0, NULL);
> >
> > This one I'm not sure about. Looks buggy.
>
> These are both Tx path for setting up offloads, Linux doesn't request
> offloads for headers outside of the linear part. The ixgbevf code is
> completely pointless, as you say.
>
> In general drivers are rarely a source of high quality code examples.
> Having been directly involved in the bugs that lead to the bnxt code
> being written - I was so happy that the driver started parsing Tx
> packets *at all*, so I wasn't too fussed by the minor problems :(
>
> > > It should *not* be supported. We had enough prod problems with people
> > > thinking that the entire header will be in the linear portion.
> > > Then either the NIC can't parse the header, someone enables jumbo,
> > > disables GRO, adds new HW, adds encap, etc etc and things implode.
> >
> > I don't see how this is related.
> > NULL buffer allows to get a linear pointer and explicitly avoids
> > slow path when it's not linear.
>
> Direct packet access via skb->data is there for those who want high
> speed =F0=9F=A4=B7=EF=B8=8F

skb->data/data_end approach unfortunately doesn't work that well.
Too much verifier fighting. That's why dynptr was introduced.

>
> > > If you want to support it in BPF that's up to you, but I think it's
> > > entirely reasonable for me to request that you don't do such things
> > > in general networking code. The function is 5 LoC, so a local BPF
> > > copy seems fine. Although I'd suggest skb_header_pointer_misguided()
> > > rather than __skb_header_pointer2() as the name :)
> >
> > If you insist we can, but bnxt is an example that buffer=3D=3DNULL is
> > a useful concept for networking and not bpf specific.
> > It also doesn't make "people think the header is linear" any worse.
>
> My worry is that people will think that whether the buffer is needed or
> not depends on _their program_, rather than on the underlying platform.
> So if it works in testing without the buffer - the buffer must not be
> required for their use case.

Are you concerned about bpf progs breaking this way?
I thought you're worried about the driver misusing
skb_header_pointer() with buffer=3D=3DNULL.

We can remove !buffer check as in the attached patch,
but I don't quite see how it would improve driver quality.

--000000000000d9ce8c0600c8d6c1
Content-Type: application/octet-stream; 
	name="0001-bpf-net-Introduce-skb_pointer_if_linear.patch"
Content-Disposition: attachment; 
	filename="0001-bpf-net-Introduce-skb_pointer_if_linear.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lk8r2ex50>
X-Attachment-Id: f_lk8r2ex50

RnJvbSBjN2IwZTQ2YmMyMjQ4NjQzZWI4YTdjNWY1MjZjMWE3ODA2OWY5NjhjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4ZWkgU3Rhcm92b2l0b3YgPGFzdEBrZXJuZWwub3JnPgpE
YXRlOiBUdWUsIDE4IEp1bCAyMDIzIDEzOjI5OjEyIC0wNzAwClN1YmplY3Q6IFtQQVRDSCBicGYt
bmV4dF0gYnBmLCBuZXQ6IEludHJvZHVjZSBza2JfcG9pbnRlcl9pZl9saW5lYXIuCgpTaWduZWQt
b2ZmLWJ5OiBBbGV4ZWkgU3Rhcm92b2l0b3YgPGFzdEBrZXJuZWwub3JnPgotLS0KIGluY2x1ZGUv
bGludXgvc2tidWZmLmggfCAxMCArKysrKysrKystCiBrZXJuZWwvYnBmL2hlbHBlcnMuYyAgIHwg
IDUgKysrKy0KIDIgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3NrYnVmZi5oIGIvaW5jbHVkZS9saW51eC9z
a2J1ZmYuaAppbmRleCA5MWVkNjY5NTI1ODAuLmYyNzZkMGU5ODE2ZiAxMDA2NDQKLS0tIGEvaW5j
bHVkZS9saW51eC9za2J1ZmYuaAorKysgYi9pbmNsdWRlL2xpbnV4L3NrYnVmZi5oCkBAIC00MDIz
LDcgKzQwMjMsNyBAQCBfX3NrYl9oZWFkZXJfcG9pbnRlcihjb25zdCBzdHJ1Y3Qgc2tfYnVmZiAq
c2tiLCBpbnQgb2Zmc2V0LCBpbnQgbGVuLAogCWlmIChsaWtlbHkoaGxlbiAtIG9mZnNldCA+PSBs
ZW4pKQogCQlyZXR1cm4gKHZvaWQgKilkYXRhICsgb2Zmc2V0OwogCi0JaWYgKCFza2IgfHwgIWJ1
ZmZlciB8fCB1bmxpa2VseShza2JfY29weV9iaXRzKHNrYiwgb2Zmc2V0LCBidWZmZXIsIGxlbikg
PCAwKSkKKwlpZiAoIXNrYiB8fCB1bmxpa2VseShza2JfY29weV9iaXRzKHNrYiwgb2Zmc2V0LCBi
dWZmZXIsIGxlbikgPCAwKSkKIAkJcmV0dXJuIE5VTEw7CiAKIAlyZXR1cm4gYnVmZmVyOwpAQCAt
NDAzNiw2ICs0MDM2LDE0IEBAIHNrYl9oZWFkZXJfcG9pbnRlcihjb25zdCBzdHJ1Y3Qgc2tfYnVm
ZiAqc2tiLCBpbnQgb2Zmc2V0LCBpbnQgbGVuLCB2b2lkICpidWZmZXIpCiAJCQkJICAgIHNrYl9o
ZWFkbGVuKHNrYiksIGJ1ZmZlcik7CiB9CiAKK3N0YXRpYyBpbmxpbmUgdm9pZCAqIF9fbXVzdF9j
aGVjaworc2tiX3BvaW50ZXJfaWZfbGluZWFyKGNvbnN0IHN0cnVjdCBza19idWZmICpza2IsIGlu
dCBvZmZzZXQsIGludCBsZW4pCit7CisJaWYgKGxpa2VseShza2JfaGVhZGxlbihza2IpIC0gb2Zm
c2V0ID49IGxlbikpCisJCXJldHVybiBza2ItPmRhdGEgKyBvZmZzZXQ7CisJcmV0dXJuIE5VTEw7
Cit9CisKIC8qKgogICoJc2tiX25lZWRzX2xpbmVhcml6ZSAtIGNoZWNrIGlmIHdlIG5lZWQgdG8g
bGluZWFyaXplIGEgZ2l2ZW4gc2tiCiAgKgkJCSAgICAgIGRlcGVuZGluZyBvbiB0aGUgZ2l2ZW4g
ZGV2aWNlIGZlYXR1cmVzLgpkaWZmIC0tZ2l0IGEva2VybmVsL2JwZi9oZWxwZXJzLmMgYi9rZXJu
ZWwvYnBmL2hlbHBlcnMuYwppbmRleCA5ZTgwZWZhNTlhNWQuLmI4YWIzYmVhNzFiNyAxMDA2NDQK
LS0tIGEva2VybmVsL2JwZi9oZWxwZXJzLmMKKysrIGIva2VybmVsL2JwZi9oZWxwZXJzLmMKQEAg
LTIyMzksNyArMjIzOSwxMCBAQCBfX2JwZl9rZnVuYyB2b2lkICpicGZfZHlucHRyX3NsaWNlKGNv
bnN0IHN0cnVjdCBicGZfZHlucHRyX2tlcm4gKnB0ciwgdTMyIG9mZnNldAogCWNhc2UgQlBGX0RZ
TlBUUl9UWVBFX1JJTkdCVUY6CiAJCXJldHVybiBwdHItPmRhdGEgKyBwdHItPm9mZnNldCArIG9m
ZnNldDsKIAljYXNlIEJQRl9EWU5QVFJfVFlQRV9TS0I6Ci0JCXJldHVybiBza2JfaGVhZGVyX3Bv
aW50ZXIocHRyLT5kYXRhLCBwdHItPm9mZnNldCArIG9mZnNldCwgbGVuLCBidWZmZXJfX29wdCk7
CisJCWlmIChidWZmZXJfX29wdCkKKwkJCXJldHVybiBza2JfaGVhZGVyX3BvaW50ZXIocHRyLT5k
YXRhLCBwdHItPm9mZnNldCArIG9mZnNldCwgbGVuLCBidWZmZXJfX29wdCk7CisJCWVsc2UKKwkJ
CXJldHVybiBza2JfcG9pbnRlcl9pZl9saW5lYXIocHRyLT5kYXRhLCBwdHItPm9mZnNldCArIG9m
ZnNldCwgbGVuKTsKIAljYXNlIEJQRl9EWU5QVFJfVFlQRV9YRFA6CiAJewogCQl2b2lkICp4ZHBf
cHRyID0gYnBmX3hkcF9wb2ludGVyKHB0ci0+ZGF0YSwgcHRyLT5vZmZzZXQgKyBvZmZzZXQsIGxl
bik7Ci0tIAoyLjM0LjEKCg==
--000000000000d9ce8c0600c8d6c1--
