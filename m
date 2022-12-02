Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D845E64079F
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Dec 2022 14:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbiLBNWs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Dec 2022 08:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiLBNWq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Dec 2022 08:22:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8594122A
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Dec 2022 05:22:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 298FA622AD
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Dec 2022 13:22:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BAF4C433D6;
        Fri,  2 Dec 2022 13:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669987364;
        bh=0LVuCvHK90xP67xYqSpII4+HmPxMJIOXna0dwxxgfyM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L4IQdxsLaBziQ0H6zXCxqx+hefbkj855E6zaz0wZLrKu9MbRZwf4Vbfz+QIMpm497
         UqDZyLAo8tffBVvlLVoIZBDi8C6q3vzK8sl8VJx/Lz+eLzL9q5hlkhWgfYtnB4zgo1
         Vl69tTsZh9Qx1E6fivwYqtIzuhCdNcNa5qn9vG11Zb01SJcgjWHxIEDJBsGqg7C53/
         2cHVRrQbWFh7PLiCl3kqPBo53W05Qf+6jAcLbfkKcs7hgQcOPg//yBWkK+H/Lmxrv2
         VLH2nwg/E0XZNcLdwn21FLSUlfOwyi1yol9WQtZhU9tnI9lzmCx+SFbtwbjG2I2dlF
         GyUBWDmuiGvOA==
Date:   Fri, 2 Dec 2022 13:22:41 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>
Cc:     Takashi Iwai <tiwai@suse.de>, Shuah Khan <shuah@kernel.org>,
        alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 0/6] kselftest/alsa: pcm-test improvements
Message-ID: <Y4n8IZbLvX0Eg/V9@sirena.org.uk>
References: <20221130000608.519574-1-broonie@kernel.org>
 <a55212fc-a676-2335-b861-94ba8d10f207@perex.cz>
 <87359zlz9t.wl-tiwai@suse.de>
 <Y4kOvNi5I8/GK1yU@sirena.org.uk>
 <87y1rqkzto.wl-tiwai@suse.de>
 <87wn7akzp7.wl-tiwai@suse.de>
 <66bef382-e38f-85d5-0e07-3cf672a89882@perex.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IwyGX8jMV1S5RL5G"
Content-Disposition: inline
In-Reply-To: <66bef382-e38f-85d5-0e07-3cf672a89882@perex.cz>
X-Cookie: Ego sum ens omnipotens.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--IwyGX8jMV1S5RL5G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 02, 2022 at 09:56:39AM +0100, Jaroslav Kysela wrote:
> On 02. 12. 22 8:54, Takashi Iwai wrote:
> > Takashi Iwai wrote:

> > > > Oh, this is getting a little confusing - I'd just picked Jaroslav's
> > > > patch into my tree and was in the middle redoing my ideas on top of his
> > > > code!  I might have something more later this evening...  I think we can
> > > > converge here, let me continue taking a look.

> > > Ah then it was my misunderstanding, and everything should be fine now
> > > ;)  Thanks!

> > Erm, you meant sent as *v3*.  I've seen now.

> > As the v2 patches were already merged, could you rather rebase and
> > resubmit?  I'd like to avoid rebase the full series that are already
> > included in linux-next.

> It's rebased. The first patch from the set drops the previous Mark's changes.

Indeed, there was so many collisions with Jaroslav's patches
which it just seemed like the most straightforward way to do
things (plus I'd already written a good chunk of the new version
by the time you applied my v2).  Probably only a small bit of the
skipping code would end up remaining anyway.

--IwyGX8jMV1S5RL5G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOJ/CAACgkQJNaLcl1U
h9DShAf+JiDRTGD6uE6v776djG9zR6+KoZIXbF0n/JUYuX8L8zWGqg8vnGPzx8tm
ZVG3h81yBYxqkNyChimYPUpotJxI7B8RDiZBGXYk/Prr7Zd3DHuBzSq3BdqDG/u4
X5DMruB6+U5N5GOiMJSpKWJ0y+LNVpffKDoyA2/PKx3VgYmydU0DJ8Rcf/VFmR2V
/7sY/PINwasgvW8igbw1KNiAgMdQGdUcZDB3rpbjboUbDB4AanWFv0ULAQxQojy5
J7zPnbe8FFid2NE8ofVRbAeS3Q/BLnyq4tVMRDApv7zVWNZAVRnWFNDpqa5Mnn3d
ijAzxPl0j2ks2URDkqGEaeONEtraeg==
=aHCd
-----END PGP SIGNATURE-----

--IwyGX8jMV1S5RL5G--
