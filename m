Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FC174265E
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jun 2023 14:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbjF2M1V (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jun 2023 08:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbjF2M06 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jun 2023 08:26:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BAE3C07;
        Thu, 29 Jun 2023 05:26:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CDDA121854;
        Thu, 29 Jun 2023 12:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1688041592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wC2m3Yx3psKkEPLlun+ONLgR44D7q3seUbrUL2S3T30=;
        b=ZyZqr+cHIpkjvoD03dDSgbCDBElpsaWtwxFW05ulVIk2gwfLFWUUD/kMkVJ+Z2klCfYTol
        awCaBz7pOLURmVdQCBleNV4SQ2MLu1YT635FsDtY54RcGs8Z6WWBpSSqAeC5qiHL+Bt+PT
        m2fXD2pRIfLjACuOVSVmECXejka9U5A=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AA76713905;
        Thu, 29 Jun 2023 12:26:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZE/9KHh4nWTXVwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 29 Jun 2023 12:26:32 +0000
Date:   Thu, 29 Jun 2023 14:26:31 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 1/3] cpuset: Allow setscheduler regardless of manipulated
 task
Message-ID: <4fowzgkh7yo5ku2fsrptyi7jzikynjtq4zpfcx7k26vk4k6zj3@ubnupp5jqgle>
References: <20230629091146.28801-1-mkoutny@suse.com>
 <20230629091146.28801-2-mkoutny@suse.com>
 <15c607d9-c1fa-ca11-d675-8f2b3a6fd15b@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rblx2idammiw6ntz"
Content-Disposition: inline
In-Reply-To: <15c607d9-c1fa-ca11-d675-8f2b3a6fd15b@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--rblx2idammiw6ntz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 29, 2023 at 08:11:33AM -0400, Waiman Long <longman@redhat.com> =
wrote:
> So I think you should just use
> cgroup_subsys_on_dfl(cpuset_cgrp_subsys) as the v2 check if your focus
> is just to prevent problem when enabling cpuset controller.

I thought the bare cgroup_subsys_on_dfl(cpuset_cgrp_subsys) is not used
in cpuset.c but I was wrong -- yes, I'll change this.

> This change will likely conflict with the latest cpuset change on trackin=
g #
> of dl tasks in a cpuset. You will have to, at least, move the dl task che=
ck
> before the security_task_setscheduler() check.
>=20
> Another fact about cpuset controller enabling is that both cpus_allowed a=
nd
> mems_allowed are empty at that point. You may also add these checks as a
> preconditions for disabling the security_task_setscheduler check.

Ah, I will rebase on fresh mainline (or do you mean another reference?).

Thanks for the hints,
Michal

--rblx2idammiw6ntz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZJ14dQAKCRAGvrMr/1gc
jgWhAQCg5qoiDOfhNkRuhbqMER6ksJi/9R3UMnsTyDByQxNHcgD9Hxgyt1VPPcbL
NtdTozyc/W59t7siU73cfznURZII+Qk=
=E0Xs
-----END PGP SIGNATURE-----

--rblx2idammiw6ntz--
