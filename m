Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A487E3275
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Nov 2023 02:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjKGBGd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Nov 2023 20:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjKGBGd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Nov 2023 20:06:33 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F6C103
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Nov 2023 17:06:29 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7c97d5d5aso69749147b3.3
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Nov 2023 17:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699319189; x=1699923989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ohxi5+Y03NUxyd7Z+WD2LsK2yf5hWz3IWyTmbwaWelU=;
        b=pm6Pgau+IEMYO59ztYfejyPpAV0G1Ij2TqdE3nkiVLUQchMLCjep1TtINJn6JlC5AW
         q1fuayRi8x1+on7Nl9kP+CQDwnmA4U3dILDbPV3X6MxBoJOkVGFH7DpbW5H38l++06Zk
         2yPmbg+ikmBDFAyjW3PZPxyLtMmfCVrCez3639ApitO5CLyto5kRiPjje4z4/EyPxs0R
         p3YVryOdTSlOCIMfJaV+lsJZk9RgZSi7D37kXT9lUDlnywCpdNDXA2t6LI8SrLKCKfD7
         ap9twuMWYNLeREdwPKiKoBE1jJP1Ajghv1zG7AwQF9Ys81Ig+tmR5zyuFnXRtwgkvNdZ
         31Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699319189; x=1699923989;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ohxi5+Y03NUxyd7Z+WD2LsK2yf5hWz3IWyTmbwaWelU=;
        b=YbPG2WIs9lKIh+Q+Ph7S2KDbXxK6mtJTwpd4IzjrHs8K4X4qFww3KIdRtYfsHqf0kx
         0Sdv2IPB6NpHLMrtfG5JC27CMyvpKdFFGLEcPpXbETL5w0eeMgzT2v4WGTL1odLJfBRF
         Q/vXlbsmr/XlDdz2uEKRV9X+NQNe0lAHRmUuyo3L7lQFxtTcoWPLwVUKQwwJBtod5rEx
         yOotfP+CxbQ0YthHrwMVkkk0qh/KmaFqfQxm7BwIfE6OKSh2ycuWOy7eUOF6jGZZ3KYD
         gspnQv1ZvxF/zpCWFBb0lhcDOtrhFqJ4l0G1x+XaXAVS8qx9+mtbBKT6UKvRblE7oOXM
         Susg==
X-Gm-Message-State: AOJu0Yz2ekeQ4a5RbcDfl9yFfa5KKvLUyluwg/K7xTIEXdtvFEk8dFj3
        vx8xu1Zw8JcPneRLYRcnSnUCr+w=
X-Google-Smtp-Source: AGHT+IHuQTOjvZnlRHNnD2CvocinTRlTmqL5PQwl1eaZKT6yHcPv7t7NpUobWTImvAwkWaOkXlZ+pP4=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:68cc:0:b0:da0:622b:553b with SMTP id
 d195-20020a2568cc000000b00da0622b553bmr541284ybc.12.1699319188777; Mon, 06
 Nov 2023 17:06:28 -0800 (PST)
Date:   Mon, 6 Nov 2023 17:06:27 -0800
In-Reply-To: <CAHS8izNxKHhW5uCqmfau6n3c18=hE3RXzA+ng5LEGiKj12nGcg@mail.gmail.com>
Mime-Version: 1.0
References: <ZUk03DhWxV-bOFJL@google.com> <19129763-6f74-4b04-8a5f-441255b76d34@kernel.org>
 <CAHS8izMrnVUfbbS=OcJ6JT9SZRRfZ2MC7UnggthpZT=zf2BGLA@mail.gmail.com>
 <ZUlhu4hlTaqR3CTh@google.com> <CAHS8izMaAhoae5ChnzO4gny1cYYnqV1cB8MC2cAF3eoyt+Sf4A@mail.gmail.com>
 <ZUlvzm24SA3YjirV@google.com> <CAHS8izMQ5Um_ScY0VgAjaEaT-hRh4tFoTgc6Xr9Tj5rEj0fijA@mail.gmail.com>
 <CAKH8qBsbh8qYxNHZ6111RQFFpNWbWZtg0LDXkn15xcsbAq4R6w@mail.gmail.com>
 <CAF=yD-+BuKXoVL8UF+No1s0TsHSzBTz7UrB1Djt_BrM74uLLcg@mail.gmail.com> <CAHS8izNxKHhW5uCqmfau6n3c18=hE3RXzA+ng5LEGiKj12nGcg@mail.gmail.com>
Message-ID: <ZUmNk98LyO_Ntcy7@google.com>
Subject: Re: [RFC PATCH v3 09/12] net: add support for skbs with unreadable frags
From:   Stanislav Fomichev <sdf@google.com>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "Christian =?utf-8?B?S8O2bmln?=" <christian.koenig@amd.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/06, Mina Almasry wrote:
> On Mon, Nov 6, 2023 at 4:08=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > On Mon, Nov 6, 2023 at 3:55=E2=80=AFPM Stanislav Fomichev <sdf@google.c=
om> wrote:
> > >
> > > On Mon, Nov 6, 2023 at 3:27=E2=80=AFPM Mina Almasry <almasrymina@goog=
le.com> wrote:
> > > >
> > > > On Mon, Nov 6, 2023 at 2:59=E2=80=AFPM Stanislav Fomichev <sdf@goog=
le.com> wrote:
> > > > >
> > > > > On 11/06, Mina Almasry wrote:
> > > > > > On Mon, Nov 6, 2023 at 1:59=E2=80=AFPM Stanislav Fomichev <sdf@=
google.com> wrote:
> > > > > > >
> > > > > > > On 11/06, Mina Almasry wrote:
> > > > > > > > On Mon, Nov 6, 2023 at 11:34=E2=80=AFAM David Ahern <dsaher=
n@kernel.org> wrote:
> > > > > > > > >
> > > > > > > > > On 11/6/23 11:47 AM, Stanislav Fomichev wrote:
> > > > > > > > > > On 11/05, Mina Almasry wrote:
> > > > > > > > > >> For device memory TCP, we expect the skb headers to be=
 available in host
> > > > > > > > > >> memory for access, and we expect the skb frags to be i=
n device memory
> > > > > > > > > >> and unaccessible to the host. We expect there to be no=
 mixing and
> > > > > > > > > >> matching of device memory frags (unaccessible) with ho=
st memory frags
> > > > > > > > > >> (accessible) in the same skb.
> > > > > > > > > >>
> > > > > > > > > >> Add a skb->devmem flag which indicates whether the fra=
gs in this skb
> > > > > > > > > >> are device memory frags or not.
> > > > > > > > > >>
> > > > > > > > > >> __skb_fill_page_desc() now checks frags added to skbs =
for page_pool_iovs,
> > > > > > > > > >> and marks the skb as skb->devmem accordingly.
> > > > > > > > > >>
> > > > > > > > > >> Add checks through the network stack to avoid accessin=
g the frags of
> > > > > > > > > >> devmem skbs and avoid coalescing devmem skbs with non =
devmem skbs.
> > > > > > > > > >>
> > > > > > > > > >> Signed-off-by: Willem de Bruijn <willemb@google.com>
> > > > > > > > > >> Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
> > > > > > > > > >> Signed-off-by: Mina Almasry <almasrymina@google.com>
> > > > > > > > > >>
> > > > > > > > > >> ---
> > > > > > > > > >>  include/linux/skbuff.h | 14 +++++++-
> > > > > > > > > >>  include/net/tcp.h      |  5 +--
> > > > > > > > > >>  net/core/datagram.c    |  6 ++++
> > > > > > > > > >>  net/core/gro.c         |  5 ++-
> > > > > > > > > >>  net/core/skbuff.c      | 77 +++++++++++++++++++++++++=
+++++++++++------
> > > > > > > > > >>  net/ipv4/tcp.c         |  6 ++++
> > > > > > > > > >>  net/ipv4/tcp_input.c   | 13 +++++--
> > > > > > > > > >>  net/ipv4/tcp_output.c  |  5 ++-
> > > > > > > > > >>  net/packet/af_packet.c |  4 +--
> > > > > > > > > >>  9 files changed, 115 insertions(+), 20 deletions(-)
> > > > > > > > > >>
> > > > > > > > > >> diff --git a/include/linux/skbuff.h b/include/linux/sk=
buff.h
> > > > > > > > > >> index 1fae276c1353..8fb468ff8115 100644
> > > > > > > > > >> --- a/include/linux/skbuff.h
> > > > > > > > > >> +++ b/include/linux/skbuff.h
> > > > > > > > > >> @@ -805,6 +805,8 @@ typedef unsigned char *sk_buff_dat=
a_t;
> > > > > > > > > >>   *  @csum_level: indicates the number of consecutive =
checksums found in
> > > > > > > > > >>   *          the packet minus one that have been verif=
ied as
> > > > > > > > > >>   *          CHECKSUM_UNNECESSARY (max 3)
> > > > > > > > > >> + *  @devmem: indicates that all the fragments in this=
 skb are backed by
> > > > > > > > > >> + *          device memory.
> > > > > > > > > >>   *  @dst_pending_confirm: need to confirm neighbour
> > > > > > > > > >>   *  @decrypted: Decrypted SKB
> > > > > > > > > >>   *  @slow_gro: state present at GRO time, slower prep=
are step required
> > > > > > > > > >> @@ -991,7 +993,7 @@ struct sk_buff {
> > > > > > > > > >>  #if IS_ENABLED(CONFIG_IP_SCTP)
> > > > > > > > > >>      __u8                    csum_not_inet:1;
> > > > > > > > > >>  #endif
> > > > > > > > > >> -
> > > > > > > > > >> +    __u8                    devmem:1;
> > > > > > > > > >>  #if defined(CONFIG_NET_SCHED) || defined(CONFIG_NET_X=
GRESS)
> > > > > > > > > >>      __u16                   tc_index;       /* traffi=
c control index */
> > > > > > > > > >>  #endif
> > > > > > > > > >> @@ -1766,6 +1768,12 @@ static inline void skb_zcopy_do=
wngrade_managed(struct sk_buff *skb)
> > > > > > > > > >>              __skb_zcopy_downgrade_managed(skb);
> > > > > > > > > >>  }
> > > > > > > > > >>
> > > > > > > > > >> +/* Return true if frags in this skb are not readable =
by the host. */
> > > > > > > > > >> +static inline bool skb_frags_not_readable(const struc=
t sk_buff *skb)
> > > > > > > > > >> +{
> > > > > > > > > >> +    return skb->devmem;
> > > > > > > > > >
> > > > > > > > > > bikeshedding: should we also rename 'devmem' sk_buff fl=
ag to 'not_readable'?
> > > > > > > > > > It better communicates the fact that the stack shouldn'=
t dereference the
> > > > > > > > > > frags (because it has 'devmem' fragments or for some ot=
her potential
> > > > > > > > > > future reason).
> > > > > > > > >
> > > > > > > > > +1.
> > > > > > > > >
> > > > > > > > > Also, the flag on the skb is an optimization - a high lev=
el signal that
> > > > > > > > > one or more frags is in unreadable memory. There is no re=
quirement that
> > > > > > > > > all of the frags are in the same memory type.
> > > > > > >
> > > > > > > David: maybe there should be such a requirement (that they al=
l are
> > > > > > > unreadable)? Might be easier to support initially; we can rel=
ax later
> > > > > > > on.
> > > > > > >
> > > > > >
> > > > > > Currently devmem =3D=3D not_readable, and the restriction is th=
at all the
> > > > > > frags in the same skb must be either all readable or all unread=
able
> > > > > > (all devmem or all non-devmem).
> > > > > >
> > > > > > > > The flag indicates that the skb contains all devmem dma-buf=
 memory
> > > > > > > > specifically, not generic 'not_readable' frags as the comme=
nt says:
> > > > > > > >
> > > > > > > > + *     @devmem: indicates that all the fragments in this s=
kb are backed by
> > > > > > > > + *             device memory.
> > > > > > > >
> > > > > > > > The reason it's not a generic 'not_readable' flag is becaus=
e handing
> > > > > > > > off a generic not_readable skb to the userspace is semantic=
ally not
> > > > > > > > what we're doing. recvmsg() is augmented in this patch seri=
es to
> > > > > > > > return a devmem skb to the user via a cmsg_devmem struct wh=
ich refers
> > > > > > > > specifically to the memory in the dma-buf. recvmsg() in thi=
s patch
> > > > > > > > series is not augmented to give any 'not_readable' skb to t=
he
> > > > > > > > userspace.
> > > > > > > >
> > > > > > > > IMHO skb->devmem + an skb_frags_not_readable() as implement=
ed is
> > > > > > > > correct. If a new type of unreadable skbs are introduced to=
 the stack,
> > > > > > > > I imagine the stack would implement:
> > > > > > > >
> > > > > > > > 1. new header flag: skb->newmem
> > > > > > > > 2.
> > > > > > > >
> > > > > > > > static inline bool skb_frags_not_readable(const struct skb_=
buff *skb)
> > > > > > > > {
> > > > > > > >     return skb->devmem || skb->newmem;
> > > > > > > > }
> > > > > > > >
> > > > > > > > 3. tcp_recvmsg_devmem() would handle skb->devmem skbs is in=
 this patch
> > > > > > > > series, but tcp_recvmsg_newmem() would handle skb->newmem s=
kbs.
> > > > > > >
> > > > > > > You copy it to the userspace in a special way because your fr=
ags
> > > > > > > are page_is_page_pool_iov(). I agree with David, the skb bit =
is
> > > > > > > just and optimization.
> > > > > > >
> > > > > > > For most of the core stack, it doesn't matter why your skb is=
 not
> > > > > > > readable. For a few places where it matters (recvmsg?), you c=
an
> > > > > > > double-check your frags (all or some) with page_is_page_pool_=
iov.
> > > > > > >
> > > > > >
> > > > > > I see, we can do that then. I.e. make the header flag 'not_read=
able'
> > > > > > and check the frags to decide to delegate to tcp_recvmsg_devmem=
() or
> > > > > > something else. We can even assume not_readable =3D=3D devmem b=
ecause
> > > > > > currently devmem is the only type of unreadable frag currently.
> > > > > >
> > > > > > > Unrelated: we probably need socket to dmabuf association as w=
ell (via
> > > > > > > netlink or something).
> > > > > >
> > > > > > Not sure this is possible. The dma-buf is bound to the rx-queue=
, and
> > > > > > any packets that land on that rx-queue are bound to that dma-bu=
f,
> > > > > > regardless of which socket that packet belongs to. So the assoc=
iation
> > > > > > IMO must be rx-queue to dma-buf, not socket to dma-buf.
> > > > >
> > > > > But there is still always 1 dmabuf to 1 socket association (on rx=
), right?
> > > > > Because otherwise, there is no way currently to tell, at recvmsg,=
 which
> > > > > dmabuf the received token belongs to.
> > > > >
> > > >
> > > > Yes, but this 1 dma-buf to 1 socket association happens because the
> > > > user binds the dma-buf to an rx-queue and configures flow steering =
of
> > > > the socket to that rx-queue.
> > >
> > > It's still fixed and won't change during the socket lifetime, right?
>=20
> Technically, no.
>=20
> The user is free to modify or delete flow steering rules outside of
> the lifetime of the socket. Technically it's possible for the user to
> reconfigure flow steering while the socket is simultaneously
> receiving, and the result will be packets switching
>  from devmem to non-devmem. For a reasonably correctly configured
> application the application would probably want to steer 1 flow to 1
> dma-buf and never change it, but this is not something we enforce, but
> rather the user orchestrates. In theory someone can find a use case
> for configuring and unconfigure flow steering during a connection.

If we do want to support this flexible configuration then we also
should export some dmabuf id along with the token?
=20
> > > And the socket has to know this association; otherwise those tokens
> > > are useless since they don't carry anything to identify the dmabuf.
> > >
> > > I think my other issue with MSG_SOCK_DEVMEM being on recvmsg is that
> > > it somehow implies that I have an option of passing or not passing it
> > > for an individual system call.
>=20
> You do have the option of passing it or not passing it per system
> call. The MSG_SOCK_DEVMEM says the application is willing to receive
> devmem cmsgs - that's all. The application doesn't get to decide
> whether it's actually going to receive a devmem cmsg or not, because
> that's dictated by the type of skb that is present in the receive
> queue, and not up to the application. I should explain this in the
> commit message...

What would be the case of passing it or not passing it? Some fallback to
the host memory after flow steering update? Yeah, would be useful to
document those constrains. I'd lean on starting stricter and relaxing
those conditions if we find the use-cases.

> > > If we know that we're going to use dmabuf with the socket, maybe we
> > > should move this flag to the socket() syscall?
> > >
> > > fd =3D socket(AF_INET6, SOCK_STREAM, SOCK_DEVMEM);
> > >
> > > ?
> >
> > I think it should then be a setsockopt called before any data is
> > exchanged, with no change of modifying mode later. We generally use
> > setsockopts for the mode of a socket. This use of the protocol field
> > in socket() for setting a mode would be novel. Also, it might miss
> > passively opened connections, or be overly restrictive: one approach
> > for all accepted child sockets.
>=20
> We can definitely move SOCK_DEVMEM to a setsockopt(). Seems more than
> reasonable.

SG, added another suggestion for SO_DEVMEM_DONTNEED on another thread
with Willem. LMK what you think.
