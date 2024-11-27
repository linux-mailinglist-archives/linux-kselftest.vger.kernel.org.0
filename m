Return-Path: <linux-kselftest+bounces-22588-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C9A9DAFC5
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Nov 2024 00:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BE312819A8
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 23:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E965192D76;
	Wed, 27 Nov 2024 23:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FuVotEQd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE793433C8
	for <linux-kselftest@vger.kernel.org>; Wed, 27 Nov 2024 23:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732749323; cv=none; b=A2z6i/6Q+s0abifpio97QL34g5+1tRDwAdO8wLq2Q0zPiyRepkiuWELVMeYbV6so4i7UcVwmopwqKv3cC3uqihCFdnS+jeEmZK0rHLmgIrtaazaqT35Nm+ZIWPww80RaRJCZoteXAHc5fn5d/IlaUC4FhdN27mt1m/WdzdMuLOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732749323; c=relaxed/simple;
	bh=+jPnjmSkIWnfw1ypNxPAHk3jExZky9QC/KYnqBebpVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hUbiyAZD+lXJ5UTBlGBDcx6mWSERY9cZQqZD5m96mTMEixPCtlHdIYrrFA1y6kPAHjkmDB8iQA3gObcA/nmLnEaghDkB1EU4Z0FYPmc39JJxcIeb39TqoKO1qlrNpYQkxfOjlXHQj2E9UipPoHiUeLJgLsyEd7RwLg9xNxNfRSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FuVotEQd; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-724e1d0a52dso40365b3a.2
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Nov 2024 15:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732749321; x=1733354121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GYut6aU/zn0xLVmf0unpLL5mLReSDppc7n+P3njEiRE=;
        b=FuVotEQdl/FB+TAFPewoIiIaBsvRSMEPXS88ETAb32BINXuhOwMk20qi83g4OeGfUf
         5cjSZBPaeZ7hoo0SJWnuhTO1IWDZBUlFiCocTNJ1guGJcAge7jyhRsX5VxzdGM9BISxh
         Iompgt+tyXqkEJ1oWUgMso9sxZ+RAFRSChaIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732749321; x=1733354121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GYut6aU/zn0xLVmf0unpLL5mLReSDppc7n+P3njEiRE=;
        b=S8FC1xECLGhz1TUWuHDMxeDBCyHE9gXsCkLivhk6IVJ7ASuSjsfQ9LlPY/5dkgDZgE
         ZsHWL71cjSBTlSZnA6jQVFfWPR3V3S7vFT3rTDL1JSihB8LMNH7eKGnGi9NBEbbdaZkM
         LgkbNhfa/rqMAC6c085KxkhF7lABUXxpiJ15Wd5/X/XYtImjlKP5OQvIuZ2cbNw1g/Yl
         aDiuH338dCnv4mEKwBXA/Z274pIClsbemYWz8vWPNDGP0MpWg/cHRTyeTBizPYuMyd9i
         sLChamqRtyGvF2iE9/2LdBxjA6jav3oRSx52wYJtz500nTbLc1AH0NMWSEuJOYPaBfTC
         kyaw==
X-Forwarded-Encrypted: i=1; AJvYcCVFPAixSVYTPvsFvJsfq3/0JgtdN71tBTrszbj7SqEobR+4sox1jRhTEtc7L2658T6ZyJzLkWnouYpe9O3ysUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLAG3oMQK7iyMlQH5Iw9lBdvKOaob6/cGqyDWVlLh3Q4ZJM7j1
	Ngzf47d6OtUfSJrdg8JM7uhQlXujjj8sLKvbM7zxeQfHQUdbHcgQRR/ellyid4WrSWOnrLI4THb
	GnmU8
X-Gm-Gg: ASbGncs49Lw/tJVHNpiPKLNXBj2JffHbqSvUapQUNM8n3dBhAh9x6zSFFnaYca5/UHw
	T8gQfuzU/szW0GS56qVu7YVyahZxHm/LADweKiDPiKKXN815mf4pLAc+SXHM2CBjzTOyL42PY4P
	25MidyMzarY5JRP8zRfuDev8bsLyQiPG5bDLzrMuoNz3nwcdTHQtlu+OLt0ljA/ayds1I57MZ4k
	ALNt/CFUuwHAjI79s33Qt8W5Ucc11GNJSouzJugL2KIjZEaZCZd3W5Ghy2+mPng6V9O/R6ES20N
	cCnl6srZR/pwr6MiUA==
X-Google-Smtp-Source: AGHT+IFswN8l6vK2RwOVMMTXDgpcYWZui5Cw8IO7Up5gdjZnl+vmRWSTOlfFn3YmwMR4zc5kOkOTLg==
X-Received: by 2002:a17:903:41d2:b0:212:3f36:cee1 with SMTP id d9443c01a7336-21501855eb2mr23821995ad.8.1732749320918;
        Wed, 27 Nov 2024 15:15:20 -0800 (PST)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com. [209.85.214.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541761309sm116455b3a.5.2024.11.27.15.15.18
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 15:15:20 -0800 (PST)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-212776d6449so2044705ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Nov 2024 15:15:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXLe4wARDSDGcQ+iD+qoiZdLy6gjJ01kR8/fYMXLURITsw1k0sJ20nX9KzQTYM1SScqRrwP+CbAv9taRwD/obs=@vger.kernel.org
X-Received: by 2002:a17:902:f382:b0:212:655c:caf with SMTP id
 d9443c01a7336-21501e5af92mr39560115ad.55.1732749318060; Wed, 27 Nov 2024
 15:15:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127025728.3689245-1-yuanchu@google.com> <20241127025728.3689245-10-yuanchu@google.com>
In-Reply-To: <20241127025728.3689245-10-yuanchu@google.com>
From: Daniel Verkamp <dverkamp@chromium.org>
Date: Wed, 27 Nov 2024 15:14:52 -0800
X-Gmail-Original-Message-ID: <CABVzXAnbSeUezF_dqk2=6HGTCd09T4rd6AssP7-dbCgZSkZgiw@mail.gmail.com>
Message-ID: <CABVzXAnbSeUezF_dqk2=6HGTCd09T4rd6AssP7-dbCgZSkZgiw@mail.gmail.com>
Subject: Re: [PATCH v4 9/9] virtio-balloon: add workingset reporting
To: Yuanchu Xie <yuanchu@google.com>
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

On Tue, Nov 26, 2024 at 7:00=E2=80=AFPM Yuanchu Xie <yuanchu@google.com> wr=
ote:
[...]
> diff --git a/include/linux/workingset_report.h b/include/linux/workingset=
_report.h
> index f6bbde2a04c3..1074b89035e9 100644
> --- a/include/linux/workingset_report.h
> +++ b/include/linux/workingset_report.h
[...]
> diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/vir=
tio_balloon.h
> index ee35a372805d..668eaa39c85b 100644
> --- a/include/uapi/linux/virtio_balloon.h
> +++ b/include/uapi/linux/virtio_balloon.h
> @@ -25,6 +25,7 @@
>   * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY=
 WAY
>   * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY O=
F
>   * SUCH DAMAGE. */
> +#include "linux/workingset_report.h"
>  #include <linux/types.h>
>  #include <linux/virtio_types.h>
>  #include <linux/virtio_ids.h>

This seems to be including a non-uapi header
(include/linux/workingset_report.h) from a uapi header
(include/uapi/linux/virtio_balloon.h), which won't compile outside the
kernel. Does anything in the uapi actually need declarations from
workingset_report.h?

> @@ -37,6 +38,7 @@
>  #define VIRTIO_BALLOON_F_FREE_PAGE_HINT        3 /* VQ to report free pa=
ges */
>  #define VIRTIO_BALLOON_F_PAGE_POISON   4 /* Guest is using page poisonin=
g */
>  #define VIRTIO_BALLOON_F_REPORTING     5 /* Page reporting virtqueue */
> +#define VIRTIO_BALLOON_F_WS_REPORTING  6 /* Working Set Size reporting *=
/
>
>  /* Size of a PFN in the balloon interface. */
>  #define VIRTIO_BALLOON_PFN_SHIFT 12
> @@ -128,4 +130,32 @@ struct virtio_balloon_stat {
>         __virtio64 val;
>  } __attribute__((packed));
>
> +/* Operations from the device */
> +#define VIRTIO_BALLOON_WS_OP_REQUEST 1
> +#define VIRTIO_BALLOON_WS_OP_CONFIG 2
> +
> +struct virtio_balloon_working_set_notify {
> +       /* REQUEST or CONFIG */
> +       __le16 op;
> +       __le16 node_id;
> +       /* the following fields valid iff op=3DCONFIG */
> +       __le32 report_threshold;
> +       __le32 refresh_interval;
> +       __le32 idle_age[WORKINGSET_REPORT_MAX_NR_BINS];
> +};
> +
> +struct virtio_balloon_working_set_report_bin {
> +       __le64 idle_age;
> +       /* bytes in this bucket for anon and file */
> +       __le64 anon_bytes;
> +       __le64 file_bytes;
> +};
> +
> +struct virtio_balloon_working_set_report {
> +       __le32 error;
> +       __le32 node_id;
> +       struct virtio_balloon_working_set_report_bin
> +               bins[WORKINGSET_REPORT_MAX_NR_BINS];
> +};
> +
>  #endif /* _LINUX_VIRTIO_BALLOON_H */

Have the spec changes been discussed in the virtio TC?

Thanks,
-- Daniel

