Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359326207AC
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 04:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbiKHDpW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 22:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbiKHDpU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 22:45:20 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B16D23178;
        Mon,  7 Nov 2022 19:45:19 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso16772412pjc.0;
        Mon, 07 Nov 2022 19:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qckFeD/Pt+sjt3ZlSfmlazZQAbxsJ1ktBLsagW6IgrQ=;
        b=FH9VAzFoXUR46qDebGlu3fcJnK6+nfGW4qTxltGPb6jzH3adwTNgTYkarxOUiNIlVO
         8ONzopdMsT3HUr26AGwrr9HvIg2iNaLFMz8QRpOdIqGaNX3fdM174GJuvGX3030eiTh1
         q7cpasGEeVPpB1eDaw9JREPbNBd65Ezz+Pfw/ZIztSwL847bk2FFrtlHrazQInx0eHf5
         RuhcW6K85YkWY25fnBJZowCCzFOEkCGNNpO5Kv7rDYPvig7cI/smneUMCUe8j6ZkDoxN
         6LJl0pEsUl4RojdAG7FQ8yyJLK3ybfAD8CgYw/FzDj8yVMpvDbkt2M53CNm3TKyeGKfm
         /Itw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qckFeD/Pt+sjt3ZlSfmlazZQAbxsJ1ktBLsagW6IgrQ=;
        b=IMPiZi+2IwARTBK++NWyfQu0R0JD/r3TvUT1pa0b2lmjaXXY+5xpvA00ip1Lz2sXhS
         goBpu1GkU7x62RIL824VfJ4FYDpF1Gfl5+NjjQg//hOMaO+WJd/VXUpiHtk9zblGKvaJ
         f5rBZOuvEOf81P//aOJMKaduq3nxwTWaxnxl+G9pLKFHyQpPqDAleHam19czt5eAmF8/
         fighw8YRxd4t6HRwPBDyZEyH4GtOInNKEoqxKig94J2kqf0Ygo9p492Gpn6bz56QwDGP
         k4XR9/3BGE3MmV8iPZ1VuHjkfHjjPSq/vmIRZbWB+X0qNeZf7dkXFe4DTp6NQLOWPeLI
         Vmqw==
X-Gm-Message-State: ACrzQf0tHHKQ+//TpC0+OqBVjHhpxv4H1KAVA1gqCs3TKxbDw+5HWFQ3
        WhPu+tMlrpuesuKe2/Am8uI=
X-Google-Smtp-Source: AMsMyM5tBTqgUASBPjV21N8H6J2m+peEz7OGJWQsDcGg1rbGeXDb0doOv+V8wKJ1pTFS9FnJWBBTCg==
X-Received: by 2002:a17:902:c94a:b0:186:e68a:9aad with SMTP id i10-20020a170902c94a00b00186e68a9aadmr53540653pla.72.1667879118728;
        Mon, 07 Nov 2022 19:45:18 -0800 (PST)
Received: from debian.me (subs02-180-214-232-93.three.co.id. [180.214.232.93])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090322cf00b00176d347e9a7sm5752203plg.233.2022.11.07.19.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 19:45:17 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 1B5A51038C6; Tue,  8 Nov 2022 10:45:10 +0700 (WIB)
Date:   Tue, 8 Nov 2022 10:45:10 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     bpf@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v4 04/17] iommufd: Document overview of iommufd
Message-ID: <Y2nQxvRQKYtSAfTc@debian.me>
References: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <4-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VlYIyqR9GGcDMQ/y"
Content-Disposition: inline
In-Reply-To: <4-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--VlYIyqR9GGcDMQ/y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 07, 2022 at 08:48:57PM -0400, Jason Gunthorpe wrote:
> From: Kevin Tian <kevin.tian@intel.com>
>=20
> Add iommufd into the documentation tree, and supply initial documentation.
> Much of this is linked from code comments by kdoc.
>=20

The documentation LGTM, thanks.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--VlYIyqR9GGcDMQ/y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY2nQwQAKCRD2uYlJVVFO
ozsKAPwOuRyOmFizFmjuooe/gexDrhdGHJSdBsMEQGnAYJfwKgEAsJqlXtWAwodg
hHXROiqV7JqrnspKYDSIglvCm5IePAc=
=NHaN
-----END PGP SIGNATURE-----

--VlYIyqR9GGcDMQ/y--
