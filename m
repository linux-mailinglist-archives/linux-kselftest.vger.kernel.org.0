Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43905AC373
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Sep 2022 10:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbiIDI1P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 4 Sep 2022 04:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiIDI1L (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 4 Sep 2022 04:27:11 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0608941D1C;
        Sun,  4 Sep 2022 01:27:09 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id s14-20020a17090a6e4e00b0020057c70943so231627pjm.1;
        Sun, 04 Sep 2022 01:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=zfiWejN/Bz3YBQupNom1bcY/9klYVsjCN66XEd476z0=;
        b=SBEuv7blCe057KcuIJdNRyj3g2VOPTQq1llrfLNFf289npI8wf/m4D6m8V6XY3lUXp
         Re5/g1GMCzHeowzixKLlyMxv657lA13nPeZhWWJ2OC266RIOX72T1P7U1QIAkGITZTkZ
         OhFiv4GP/cj1MqfFk/e6TYkNwyKqbZZknzVH95RjMeoEs2gWuzEfbEQyCHG1wbtuLJHO
         pjSg3+fSIKJmTcugr2ndTCmihpEGjkt8TbVpopZ7zzVFWdZ8gYe+YJI8gXqyPjNVYdVK
         Rz3pc71J6gK/cLFZWzrR+DMSWgYikjoU/F8/eqeKn7KVfwAFofKX6tJeywPhCEF2HQqP
         7Blw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=zfiWejN/Bz3YBQupNom1bcY/9klYVsjCN66XEd476z0=;
        b=gkb7W3gUoeEZxpMzzIclRYJJa2pHcrDJ+1jVRnHM2CW9ehjuYjXLvAXk6f/LWQb/K5
         VnOhJPAnq8O8UqR0vEOTUFMCOShg/+m/xcIjS6uvCMGab9ZRsKTvVHpColDVJzNfa4uc
         tvlaon62fjei1jT4JBZYBkAS23qpNVmVUKhXZpGFjnC5nqmVpcoNmelufXN5fagunMAR
         H85xuZPrRESC7pYcv4vtle8yGqol89VEH7rBp0rN4TiSxwiFDr0cUcs8+LK5tsfxsnkD
         xIcOws+M/Xl/x1RgyzSiJWKEgoRj138U8/jLYdQi3I/9GaVSY1JlpSQIoiR8zA93ufPN
         VkiQ==
X-Gm-Message-State: ACgBeo1vymS+0VUVjsXKMdixhPKv8I96PsIXcpdcmcC7EBnIG372qad4
        vlAvFdvAggwFOiiKybqZmyo=
X-Google-Smtp-Source: AA6agR6p1vnEmVhMR4O8lPoCRt91HpCjcE3g3bJe1rFhs/kMi/uJluoc3/u+nZq0YPRXXKdaBaDdUg==
X-Received: by 2002:a17:90b:3a81:b0:1fd:c490:4f08 with SMTP id om1-20020a17090b3a8100b001fdc4904f08mr13328363pjb.105.1662280028369;
        Sun, 04 Sep 2022 01:27:08 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-16.three.co.id. [180.214.232.16])
        by smtp.gmail.com with ESMTPSA id y11-20020a17090322cb00b001744018def7sm4901806plg.90.2022.09.04.01.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 01:27:08 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 521D0102D35; Sun,  4 Sep 2022 15:20:28 +0700 (WIB)
Date:   Sun, 4 Sep 2022 15:20:27 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Subject: Re: [PATCH v12 09/10] cgroup/cpuset: Update description of
 cpuset.cpus.partition in cgroup-v2.rst
Message-ID: <YxRfy/SaKkJSm5jY@debian.me>
References: <20220901205745.323326-1-longman@redhat.com>
 <20220901205745.323326-10-longman@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oIHDfZi7tkZKklmK"
Content-Disposition: inline
In-Reply-To: <20220901205745.323326-10-longman@redhat.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--oIHDfZi7tkZKklmK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 01, 2022 at 04:57:44PM -0400, Waiman Long wrote:
>  	It accepts only the following input values when written to.
> =20
>  	  =3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -	  "root"	a partition root
> -	  "member"	a non-root member of a partition
> +	  "member"	Non-root member of a partition
> +	  "root"	Partition root
> +	  "isolated"	Partition root without load balancing
>  	  =3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
><snipped>
> +	On read, the "cpuset.cpus.partition" file can show the following
> +	values.
> +
> +	  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +	  "member"			Non-root member of a partition
> +	  "root"			Partition root
> +	  "isolated"			Partition root without load balancing
> +	  "root invalid (<reason>)"	Invalid partition root
> +	  "isolated invalid (<reason>)"	Invalid isolated partition root
> +	  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +

These tables above produced htmldocs warnings:

Documentation/admin-guide/cgroup-v2.rst:2191: WARNING: Malformed table.
Text in column margin in table line 4.

=3D=3D=3D=3D=3D=3D=3D=3D      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
"member"      Non-root member of a partition
"root"        Partition root
"isolated"    Partition root without load balancing
=3D=3D=3D=3D=3D=3D=3D=3D      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Documentation/admin-guide/cgroup-v2.rst:2229: WARNING: Malformed table.
Text in column margin in table line 5.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D        =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
"member"                      Non-root member of a partition
"root"                        Partition root
"isolated"                    Partition root without load balancing
"root invalid (<reason>)"     Invalid partition root
"isolated invalid (<reason>)" Invalid isolated partition root
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D        =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

I have applied the fixup:

---- >8 ----

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-=
guide/cgroup-v2.rst
index 76b3ea9fd5c560..77b6faecf066cb 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2185,11 +2185,11 @@ Cpuset Interface Files
=20
 	It accepts only the following input values when written to.
=20
-	  =3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+	  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 	  "member"	Non-root member of a partition
 	  "root"	Partition root
 	  "isolated"	Partition root without load balancing
-	  =3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+	  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 	The root cgroup is always a partition root and its state
 	cannot be changed.  All other non-root cgroups start out as
@@ -2222,13 +2222,13 @@ Cpuset Interface Files
 	On read, the "cpuset.cpus.partition" file can show the following
 	values.
=20
-	  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
+	  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 	  "member"			Non-root member of a partition
 	  "root"			Partition root
 	  "isolated"			Partition root without load balancing
 	  "root invalid (<reason>)"	Invalid partition root
 	  "isolated invalid (<reason>)"	Invalid isolated partition root
-	  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
+	  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 	In the case of an invalid partition root, a descriptive string on
 	why the partition is invalid is included within parentheses.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--oIHDfZi7tkZKklmK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCYxRfxAAKCRD2uYlJVVFO
o3SHAQClBqZgslhw004gM4yBhkfde6wdEJ2nw/MXorNJ8fTClQD+JtUvFXJzGoUu
rSAT7jqqrPGSs2nO4gsLQKWjeu/V6gQ=
=Tjsc
-----END PGP SIGNATURE-----

--oIHDfZi7tkZKklmK--
