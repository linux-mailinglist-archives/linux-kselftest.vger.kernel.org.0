Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A135D744279
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jun 2023 20:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbjF3Sm7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Jun 2023 14:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbjF3Sm6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Jun 2023 14:42:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0FD3C00;
        Fri, 30 Jun 2023 11:42:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C601D2185A;
        Fri, 30 Jun 2023 18:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1688150572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hzP6++sspeiMJGly5/GKvnU83DNQrkePv6Ujpx4JBFo=;
        b=WzwMOUZ7URL2pshBLAbrR5Eb1snRRrtSTCfPeViixI6CoyWR3brJj+Opy8GY3af3RexoqS
        QBRbdHfDEjAv47pVfxR/ZLVfOcteQydj6yXqtbF8EHg4iVioohn/g7MPxHxp/GqDb9Bwz/
        4ZK6Zr+Q+n15blaSHPLRsoHSPyG0mY4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 98B59138F8;
        Fri, 30 Jun 2023 18:42:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Vw50JCwin2SUbgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 30 Jun 2023 18:42:52 +0000
Date:   Fri, 30 Jun 2023 20:42:51 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 1/3] cpuset: Allow setscheduler regardless of manipulated
 task
Message-ID: <qmxqf4cnt4ajt7y43vmy7xjf7mgljnq4gxqkiqdmaadrcq4lfx@f4kxwy5wygvm>
References: <20230629091146.28801-1-mkoutny@suse.com>
 <20230629091146.28801-2-mkoutny@suse.com>
 <15c607d9-c1fa-ca11-d675-8f2b3a6fd15b@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v3oci5sln533st5v"
Content-Disposition: inline
In-Reply-To: <15c607d9-c1fa-ca11-d675-8f2b3a6fd15b@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--v3oci5sln533st5v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 29, 2023 at 08:11:33AM -0400, Waiman Long <longman@redhat.com> wrote:
> Another fact about cpuset controller enabling is that both cpus_allowed and
> mems_allowed are empty at that point. You may also add these checks as a
> preconditions for disabling the security_task_setscheduler check.

I considered relying on that, however, there is more generic case when
migrating between two sibling that should be allowed in v2 too.
See the added test_cpuset_perms_object(). (Admittedly, it doesn't stress
the case when the two siblings had different CPUs but it could.)

Anyway, let's move on to v2 (where I addressed remaining comments).

Thanks,
Michal

--v3oci5sln533st5v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZJ8iKAAKCRAGvrMr/1gc
jsKlAP9Aq4WN+NlTiUnIUf8PeXwyJiCKLc3wgk3m+bILYfDpZgD7B4/zkWylYWB9
ySZ09DxxEk78SmXA9ZCPzwHdr/SkQAU=
=b3pu
-----END PGP SIGNATURE-----

--v3oci5sln533st5v--
