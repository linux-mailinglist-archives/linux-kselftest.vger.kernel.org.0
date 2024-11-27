Return-Path: <linux-kselftest+bounces-22591-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 894129DAFE7
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Nov 2024 00:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBC50B215EE
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 23:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E109199236;
	Wed, 27 Nov 2024 23:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K6wUeIa4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6195198E6F
	for <linux-kselftest@vger.kernel.org>; Wed, 27 Nov 2024 23:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732750728; cv=none; b=W0Y9U/8UPX1Ob5o/HeTDI5rZAxm6H2Uk8SH+do6RTWDW59xqYL81ULlq0IckL49LmO8mhFJYncywbrNsYyRrjEbOgznFjU3Ad2WPBPPm9WL1esbH+xB95gN4iz66Nfe5/hPgK4alh6xv6prCaxsffWxdVctExNORvtcoFtD9yks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732750728; c=relaxed/simple;
	bh=wWxmOxXxJwf00+naJRgY3wwuTvdFhzk21ESuvkmq7a0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fmwm019qf+bzmWVw82/f6GvS4X5PkoYfcOwbfpB+hjvQINrn5B3nHIiTbcNYNx2CiK4v6zUx4n880bT+5ch7/BUsW7FopRRlKOy/GVq/SC49YpCQYRCyB1BZaJayEGwgUXkUC4tvPmYxca16TGutL8zs/9fCEU2iJdWcUE1sZ0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K6wUeIa4; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-211eb2be4a8so9355ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Nov 2024 15:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732750726; x=1733355526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3WtH4trghzSdXXPfTxGxbair0NPafuCGwouqPLkhJM=;
        b=K6wUeIa4zq75yNdS86uyL1sn9GSlwvgstwcGKNhdJDGXdh+zalQFQmUd8jildBnRS/
         7+eLe1Umu9OWrOHV7DzPjzv7zzeffRPbeVAWSFbnPD93WtXaftHwv6nHyQqV13IdVyUt
         kD6ewDT57RoJSf//Gr8wLolaiuFHYE+HcspaFtf/VDXxoKGvra32XmlTOS3eipfpXP1V
         IK/p+it1wVuqh3wGpB4m3Ie9GGMKWTrPXEx9KRSVHsNDJGbc9jxeT0pHj44/8RyGKB9Y
         SqU+23XEQVKKe3ZRlwh8PyAb40sU6mZCrzlK6dhFVM9e/uktOI3gaavf/2gv80HqC+Qn
         Lytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732750726; x=1733355526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E3WtH4trghzSdXXPfTxGxbair0NPafuCGwouqPLkhJM=;
        b=G0M11Fo4PSVKcuiuq2R0b+TMPV1CQTd+TcTqiiT23NVeHxsUD1xqlzbuzPZSXffJ1C
         MucsSi9KQmwre9aSP6EzMl5pHbgOIluoazy+eRHdxur1Dj0FhvFY6ps4AK8XnDHcBOz1
         4a38XuZ8EFgVFwyj4wFv7SzVHuEroR+MNtVmdDma912MTUh0eE17kgjL3dX8tNFndc/j
         QzbhPTK7xu+kpx4YjdziXWhlpRfj12ZqtO6Mf95+gpHIPivPVyLp0Ya3Wpcad3Bfveza
         CiZXAxc8+9OMoNml5HS/OoJ3dOgTYWYrOrtsVxfMRduV79Dk/mr5HeEW9A86JIrxCR9f
         GA9A==
X-Forwarded-Encrypted: i=1; AJvYcCUHZX6aQy5ZIVcv3WKl9wzRXHWsGZvF0Dg0HEAI308GEyOYkHRK67dMfV32kDj3KFSw9wuL2DANRjQoLn9sJ78=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlPxNWEpDSpx6up6nCITKinmPwFLpZnPGUjljtYK5E1wgIAVFj
	CZiWAsWyzoxAKkc+VFR3TlIdj366qMGKnw5AJGqT3QxEExIOHUDD8VJvgzrf7LA2UTTxrtw+b62
	HPevpCB2cQUzzmLKeJn7LyMq/RAdargIM80p+
X-Gm-Gg: ASbGncs1d61cAdQ/DWT2+CimB+bkNVxj88JsqIGAsjWz8Y6+gDHH5ff2vVaLk3SBN6X
	pFmCvc4xdmG52F/3BDjFde4s4bZuquv6/8MXnOColr1GAbphtxLWX932fXfM=
X-Google-Smtp-Source: AGHT+IGbmo+NCTIyHSzrGZMJ1PCr9HDG5gkQ1VMf9lBo06pyyRaJckR1C2O+1rCJt37WnntNz5FmHQXMt81lGEnrPtg=
X-Received: by 2002:a17:903:947:b0:215:1659:1721 with SMTP id
 d9443c01a7336-2151f408939mr742585ad.12.1732750725717; Wed, 27 Nov 2024
 15:38:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127025728.3689245-1-yuanchu@google.com> <20241127025728.3689245-10-yuanchu@google.com>
 <CABVzXAnbSeUezF_dqk2=6HGTCd09T4rd6AssP7-dbCgZSkZgiw@mail.gmail.com>
In-Reply-To: <CABVzXAnbSeUezF_dqk2=6HGTCd09T4rd6AssP7-dbCgZSkZgiw@mail.gmail.com>
From: Yuanchu Xie <yuanchu@google.com>
Date: Wed, 27 Nov 2024 15:38:29 -0800
Message-ID: <CAJj2-QHZvSKoErQq-oQoZLbDMuJwwdAQef-B5=WKQS9iUE+gTQ@mail.gmail.com>
Subject: Re: [PATCH v4 9/9] virtio-balloon: add workingset reporting
To: Daniel Verkamp <dverkamp@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Khalid Aziz <khalid.aziz@oracle.com>, 
	Henry Huang <henry.hj@antgroup.com>, Yu Zhao <yuzhao@google.com>, 
	Dan Williams <dan.j.williams@intel.com>, Gregory Price <gregory.price@memverge.com>, 
	Huang Ying <ying.huang@intel.com>, Lance Yang <ioworker0@gmail.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Muhammad Usama Anjum <usama.anjum@collabora.com>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Mike Rapoport <rppt@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Daniel Watson <ozzloy@each.do>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 3:15=E2=80=AFPM Daniel Verkamp <dverkamp@chromium.o=
rg> wrote:
> >   * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN A=
NY WAY
> >   * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY=
 OF
> >   * SUCH DAMAGE. */
> > +#include "linux/workingset_report.h"
> >  #include <linux/types.h>
> >  #include <linux/virtio_types.h>
> >  #include <linux/virtio_ids.h>
>
> This seems to be including a non-uapi header
> (include/linux/workingset_report.h) from a uapi header
> (include/uapi/linux/virtio_balloon.h), which won't compile outside the
> kernel. Does anything in the uapi actually need declarations from
> workingset_report.h?
Good point. I should move the relevant constants over.

> > +
> > +struct virtio_balloon_working_set_notify {
> > +       /* REQUEST or CONFIG */
> > +       __le16 op;
> > +       __le16 node_id;
> > +       /* the following fields valid iff op=3DCONFIG */
> > +       __le32 report_threshold;
> > +       __le32 refresh_interval;
> > +       __le32 idle_age[WORKINGSET_REPORT_MAX_NR_BINS];
> > +};
> > +
> > +struct virtio_balloon_working_set_report_bin {
> > +       __le64 idle_age;
> > +       /* bytes in this bucket for anon and file */
> > +       __le64 anon_bytes;
> > +       __le64 file_bytes;
> > +};
> > +
> > +struct virtio_balloon_working_set_report {
> > +       __le32 error;
> > +       __le32 node_id;
> > +       struct virtio_balloon_working_set_report_bin
> > +               bins[WORKINGSET_REPORT_MAX_NR_BINS];
> > +};
> > +
> >  #endif /* _LINUX_VIRTIO_BALLOON_H */
>
> Have the spec changes been discussed in the virtio TC?
They have not. Thanks for bringing this up. I'll post in the VIRTIO TC.

Thanks,
Yuanchu

