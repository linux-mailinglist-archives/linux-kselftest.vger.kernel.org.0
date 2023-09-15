Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B21B7A2AE8
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Sep 2023 01:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237637AbjIOXOj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Sep 2023 19:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237994AbjIOXOT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Sep 2023 19:14:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588A310E;
        Fri, 15 Sep 2023 16:14:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBDBCC433C8;
        Fri, 15 Sep 2023 23:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694819653;
        bh=1Z00/l1SiGeTWLvlHOnOysVcKONKaxHinooGMWcK2i4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dDqQ3tpxo8jjyDwnVi0ZGycTEX97vo+xFmU9CIs2NbIctzaJ8BuNF6D9KhGOCRcYk
         NTswNodiXVNKRyTP3N85Sfqojn3+9shfYWCCb/8AkrzlvJ7XugA6aCBahNvjfuWy7j
         SKWydwTRFbkmBJiA7SZ6PM+LBj4xos33qi5MtmRsdffdH8bLoQoB3xMH9QhZzlTb67
         kJLtMFyWpW/DNeSF0OqvIyhG+uFH79pbjp4cM7uzOA3THIfJ+eD7V6ZJn9bIBJrpce
         8ByxLsZuNs/LRHTW2+KcgBe7Q4bkB3WnxxddcVw57gYDYpuA3LYU/z1i5DQTByge9c
         FbxRArxdKzaiw==
Date:   Sat, 16 Sep 2023 00:14:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     rostedt@goodmis.org, shuah@kernel.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/user_events: Fix to unmount tracefs when test
 created mount
Message-ID: <c727a9be-04b4-43e2-87f1-4bb362c41b6d@sirena.org.uk>
References: <20230915222754.16591-1-beaub@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fzQk7ZOvbv5+amqJ"
Content-Disposition: inline
In-Reply-To: <20230915222754.16591-1-beaub@linux.microsoft.com>
X-Cookie: Gravity brings me down.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--fzQk7ZOvbv5+amqJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 15, 2023 at 10:27:54PM +0000, Beau Belgrave wrote:
> Fix to unmount tracefs if the self-test mounted it to allow testing.
> If tracefs was already mounted, this does nothing.

Reviewed-by: Mark Brown <broonie@kernel.org>

--fzQk7ZOvbv5+amqJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUE5UAACgkQJNaLcl1U
h9AYmQf9Fr4MagV/99V7EwHirSdqefHMrC+ciPh1YKYJo5whta2HloAr1v7xow5d
mIBGXxgYbddy9vIKW5HjrhpIV+Il+VHCbg+DFLGipXTycHchFAc0owF4UN0qI0ot
1gZElDkvHQqHR+6uvcme3fgj4BkyPb6X9OkWqJzHyEOqHI7B2tp9/wAKORnZFbs4
fWYZUQU2Bi/Xr1yvTrkC1A8sAAn3DAk40lsBk3yR4ee7Nof/8UFpYEB9jCJzFgT1
iCq08hB+yOx/lep7bAAKe2UAtpwwHK3M68x5QfU7R2GUHtHuAwU1lp1oq1jKNGbH
w0rquf07cBASumS9RCeKauyeqtaT7Q==
=HLX0
-----END PGP SIGNATURE-----

--fzQk7ZOvbv5+amqJ--
