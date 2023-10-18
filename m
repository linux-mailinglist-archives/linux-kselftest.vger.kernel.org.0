Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2667CE73C
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Oct 2023 20:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjJRSzC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Oct 2023 14:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjJRSzB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Oct 2023 14:55:01 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8941B11A
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Oct 2023 11:54:59 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-41b813f0a29so51371cf.0
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Oct 2023 11:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697655298; x=1698260098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NFJlA+mQhi+0DERBwp78bB/+mqro8rSJvhQZ9F+v2NE=;
        b=WlSvcMi5F/jYXxVjjQcOVuG7FVY9JhBio0abDr6dtY+dGMzncWxQZdEqvyjdLwY3H5
         mgSRekPrWheEXYi4QVxifQo8Z8b5FxJZX4fDGDhXv4Tv8OGRmSnFFAf8HoZceAyu5r63
         J9k7UcPcoJgm4g8JjwCTAsoSkgVTa9J7OCIIK3G+XQrp8okByvd4G44x5Cntvz5V8Vgq
         ZYmUuQTUEhhOxagJPOZYcS3LbvLUJtxj7KL7Tz4KP2f4EWQK1U9/pZk5m/NAuWfoQg2i
         5bLKP4tBEULzUa5+vGvAyBdxYUxjJa+ue2vgWmh4WBa9NQcelU9GLW7N50/6hxDU90kA
         H0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697655298; x=1698260098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NFJlA+mQhi+0DERBwp78bB/+mqro8rSJvhQZ9F+v2NE=;
        b=hLhOUuoAQqe3gLhFltUgAs69tvnD7A9ZyqmXgfSjNIwqBlg8SZ2SkS6ABSXpbP4G1X
         oK7KnVS6T0Ba0upGIDmi2rzU6nYvbDRKTrU+VpSrPVol5kGBUHeGXzWqy3ywUzSUoUFz
         YUGB39mPt7271cXnBFL1tUgUBbkc3t7cPrp7WfOR9Cmtgew68ZMztDSEf77JGM3ZXHDw
         vghd+cWIGgvYCNMjgNnKOR2UbS6lxCQolgzyYTTNnw9WcUh2P8m+flWaoaSdQf+AyAUN
         iCjaolgi2gk6mjQELhMtMRpZRdsU05YwJN3Uo4r2K+IfaJxq4M9IUlnmpw2NQPddoF5P
         uYuA==
X-Gm-Message-State: AOJu0YyhVFWLeYxoxh7E2plVqAQ8krD+K8UBbXYyuuXQHz2bdajCfwS3
        z1z4YKdpoTVffITyFlaS8s/gtz1CwS7yyvcJDTLeiQ==
X-Google-Smtp-Source: AGHT+IGjizzkFJ61gHRpVi03W6jxKFHsg7oR29EE+XHiKGg+Nd1AGPkE/bY4MhXNSrPSxo096Ldf5GQvn/xYA+BV/to=
X-Received: by 2002:a05:622a:668a:b0:419:77b7:da5f with SMTP id
 hx10-20020a05622a668a00b0041977b7da5fmr39818qtb.11.1697655298459; Wed, 18 Oct
 2023 11:54:58 -0700 (PDT)
MIME-Version: 1.0
References: <20231016143828.647848-1-jeffxu@chromium.org> <CAHk-=whFZoap+DBTYvJx6ohqPwn11Puzh7q4huFWDX9vBwXHgg@mail.gmail.com>
 <CALmYWFtTDAb_kpZdAe_xspqwNgK1NWJmjTxaTC=jDEMzfe297Q@mail.gmail.com>
 <CAHk-=wj87GMTH=5901ob=SjQqegAm2JYBE7E4J7skJzE64U-wQ@mail.gmail.com>
 <55960.1697566804@cvs.openbsd.org> <CALmYWFs81T=XnT=AXQTo0+9FXo=OBAV_4rrYPSn9-16O-gBTZg@mail.gmail.com>
 <95482.1697587015@cvs.openbsd.org> <CALmYWFtQX57Z7ttKxrdXQH4QupFn4vi5KfizUBH9NkmP-S1JDw@mail.gmail.com>
 <ZS/3GCKvNn5qzhC4@casper.infradead.org>
In-Reply-To: <ZS/3GCKvNn5qzhC4@casper.infradead.org>
From:   Jeff Xu <jeffxu@google.com>
Date:   Wed, 18 Oct 2023 11:54:22 -0700
Message-ID: <CALmYWFu_uY=cWzAQaLtS0CdNrm+cO7tKz4sY2Ff02WQ8mGUUXw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/8] Introduce mseal() syscall
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Theo de Raadt <deraadt@openbsd.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        jeffxu@chromium.org, akpm@linux-foundation.org,
        keescook@chromium.org, sroettger@google.com, jorgelo@chromium.org,
        groeck@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, surenb@google.com, alex.sierra@amd.com,
        apopple@nvidia.com, aneesh.kumar@linux.ibm.com,
        axelrasmussen@google.com, ben@decadent.org.uk,
        catalin.marinas@arm.com, david@redhat.com, dwmw@amazon.co.uk,
        ying.huang@intel.com, hughd@google.com, joey.gouly@arm.com,
        corbet@lwn.net, wangkefeng.wang@huawei.com,
        Liam.Howlett@oracle.com, lstoakes@gmail.com, mawupeng1@huawei.com,
        linmiaohe@huawei.com, namit@vmware.com, peterx@redhat.com,
        peterz@infradead.org, ryan.roberts@arm.com, shr@devkernel.io,
        vbabka@suse.cz, xiujianfeng@huawei.com, yu.ma@intel.com,
        zhangpeng362@huawei.com, dave.hansen@intel.com, luto@kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 18, 2023 at 8:17=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> Let's start with the purpose.  The point of mimmutable/mseal/whatever is
> to fix the mapping of an address range to its underlying object, be it
> a particular file mapping or anonymous memory.  After the call succeeds,
> it must not be possible to make any address in that virtual range point
> into any other object.
>
> The secondary purpose is to lock down permissions on that range.
> Possibly to fix them where they are, possibly to allow RW->RO transitions=
.
>
> With those purposes in mind, you should be able to deduce for any syscall
> or any madvise(), ... whether it should be allowed.
>
I got it.

IMO: The approaches mimmutable() and mseal() took are different, but
we all want to seal the memory from attackers and make the linux
application safer.

mimmutable() started  with "none of updates to the sealed address is
allowed once marked as immutable", this includes from within kernel space
including driver, or any new syscalls. It is reasonable to me.

mseal() starts with 4 syscalls from userspace, which is just a way (among m=
any
other ways) to demo what memory operation can be sealed, which happens
to meet what Chome wants.  This is an RFC, I appreciate your input.

Best regards,
-Jeff
