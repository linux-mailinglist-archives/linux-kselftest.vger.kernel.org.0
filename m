Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83DD878DABA
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Aug 2023 20:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbjH3ShB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Aug 2023 14:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245671AbjH3Pwp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Aug 2023 11:52:45 -0400
Received: from sonic310-21.consmr.mail.gq1.yahoo.com (sonic310-21.consmr.mail.gq1.yahoo.com [98.137.69.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CDD19A
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Aug 2023 08:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1693410761; bh=8CTksIvAv2QdlANLJfYI5FQM3vInY3fXsMesns0e+O8=; h=Date:From:Subject:To:Cc:References:From:Subject:Reply-To; b=h4Ew7GjVk0rHjLoaxnXW2fOnrXN6Qkmyqt/ockRwGKKNNUO9Q1K4S9hl6PcKid9I8nZWpn76BICXuMRs6SD4XuSGeA42SlYesHMpdxi4XqyvQ/NvssDkQLFCtfW13v8s+M2pNU7uLcJUKoBBuoFtl8banchWttJ65Sq5VzVNRBQ0MM1fTHtMI3C7Gx1xcNDAkG60zw+2nA4FtIqzoka5FeoeBzeYDdRgh587ATX762DhZN2yojL/nzcCDdfBVrmtJCjOAb6C/ao+PuYs2wkit/ypLYXUx7VSpIg8yi9aW613+KyfOM7+kOWqwgUa/astVF1KYZlm5wxbnO2iJ2y2Ug==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693410761; bh=0lrHScO/I7vSWMOyh4mLKLzRypQUeQIwcNAt3n0VJXy=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=l3bfb6XhIfnmyFq1o1ds8OmStgAEJ4ApeW8hGAYWmH5oEZyQCHJL0uyecqmynGvexWtyl3ERCv1d9BgI2JaBl0fbxUtNVqFjdA7KqgiqVqkn3nkjecoctz5bU2HlI4C8HV36FX2BhuTBEwUf2Y/lQeJna2s9cHOKL/00mETrX4mNbv4boiHFju7tB2DR3eBN0fGo0qjwf6jW9qGEH1CemZsxUz5akQY/B0LloUQ5QDuG4ra3MNtjhX67/qCEYpoqIsvtJola0bv2a355n4hKjxEI884RP7o/uNJ3GTdX7uusdF3r2Tf2nNP5e4q/NWbs66dUf24WJ3cR6TQw1sYDDA==
X-YMail-OSG: Xa6wI1YVM1lKeIRWpDr1AtIlgVLEYFo0v9ci1dUfIkYd8YgZSbJZMd5Z6AigbfQ
 A7O53H22YJFHIzl5OyX9bO7wl1uE28enUNkq428eq4kF_0a5XfRJPsb2pBvDlf1jzbdlQGF0Ub3l
 eaVBJ6_a9xryUh1KFeKoovKeiZLbhFvirUREIZoWD1NnLP4LfnREKTElIGOij3e4LgB7NURH25kE
 pxqvrvZERCA6c1lS5DfkiF3G2xDX14sVVAjSbdrAa.1SSywTTjMytOjZiDct9EyexVA627nBx1YP
 5fLGF0Cm_5cewxyNGjLNQrph.TTy3ehjR1QXRXHR7bDivKoMjbOxTM2Zm.GjeJbDHNRSe_uXJuoZ
 V5ihPc.1DQGgsEuirtorvxCwkK.qahVjuXAc0xgQxwC9SPgrwvtJN2MCJfFoclv7rrBOkvoPNNmW
 ghFMLvRqZWHuBEygbhoVa_msekk5dbf1ZLLckyxByS2WATt90MaQHNv27wpE3cipHLkBjtOtORiO
 7Ru0RGWzAdHuGwBghTfwEezSULxeV2h67f4vV635SwynulUf944skjMbQ5HCxzvCDVH0RxJVTJIT
 eR.vmq_WNOSYisA3O2y7_c1ZvEkwikcqXbYpjJyXW92qrgYl4BIfJUIJy24B6MOjrgxKLsXj7iEE
 lyzJGQPSRgUxhl4enVJ8ZefNSN2kIQ_YJoZmfYcIbVIapc0MIB4QYl2UaJwptbBrWd2FXIlzUrAN
 IWZv1bYafbhyrUF6XYLw8G5Q6dnswNokfhs_0.3MH_HOSsdcCOt6hDIwXS3cMjCP966owrnL1.ln
 U4GxXIaFzyygZ0yvReAYNEkKiona.yqn7qIVTvVjduu3zmo0nUvQjmsda4x6zJK71l8mQ0rgFmv2
 d37OLFS16usypVYbqZGfcdzOFg8ac6tnP_FUNwslCURftaJgdvG7TZtKDecdfiIAqpqZPBzcfZ2y
 aJqi3XmCBc09ax8UFuT_mWiJXRXg0TjldbNSXLZpcFkI0ufZegynyJh7hV6lNRy.Gkz6GKMuDJK6
 tGileUy.8y8_2UdHOHsnJo3CY151SwR6j7njsF5NXQukAYUFIiMo7yEJ0LWP1NtTFd6qTowRbasX
 WOCvX1xEz_KswN2GvOYeGIz_fEuvgEkqzl2WWTDXBPWuOXfyy1aU7eckSb8QA3UuPg2PFuOB9Zic
 EiN3rmuD0oe13P1Pc.hzcPhlohOA5q4U2hxrJCLf7T1tjcyyA2h2oyjZtXhe3uWRkVyqCl6fT5fS
 bpcqlbaa.jMfc2TxuQ7c4Mzecjfme25IDRMZEVyVSQDI5.X5gkRCie3ei1xNdqAiiwVV7Akbaj8A
 .44ZRb1L5eeZ8kryjfgx65c_RO9504qVqM4m8TaSS085FSBlGN36JWf_V9aVw6tDUc.P0wfbJcA5
 fZjZH4lpL1KsRGtZVSFusDKNFTom4rJe5bDipNC7Xn0PVTiwTQVYt2POmxeTFQgHXJEfwivJQLLb
 xFYo1tEQMmeM2cS2R8.SjcOpyBmMiwmU3cUSGZCAZ0AyEEur1g8NL2nrNSjaANY1Ydsfd_IFTtE8
 cKMxJXEz88VHFn6UJa4FJhV3pXRb7AtWc1kQTRwz.8AC_fQNiSzLAjP_Ds42vkuSVJpFx25dOcp4
 k_TLHN2SorhUoiMrsopSNGLTOOkRe8G5ZyEX_0Am8ORuWDOC0MztNrxzT59q2FNXgWYs4_A7XoaG
 axvY0hyP15l.ho0IPEkW_rgkY5u6iDrz2H3KEfp0Qjn5aUA..pABbJceqCATDailqB5.n0nxIhUc
 jmjVRBhyo3CPqfVnOUql.eay.Uxr_8oWXUggfZvWIkrHGgUIryUyRhnObHbjpbU8zOcX70uqYkeb
 qEgPb0nODHOyYmatt1PBwBBY2pi_9fg8x_xlnKC3yzq1vcxnNhTYSQsjpFWtsM3bKWRgFUtQzjeQ
 ivXMrPzTMjUiQqZQuXOCyOpIXOJ600QIf.qh_hv2PvhCPLGkJSa5fq_pULf51A.V_L6AYKUgDBd.
 DfheRPe1.AHwseXPANVWkDoianH9KV_dRS1gbFSfRQDQ6r_JPBf5hpxLGdxNWKduQrpycQbZvI_T
 Xj5UzC_.zUwIoDu2Q1lz4r3RyPJtLyBdHwiTIlLaYDuVruJwMFlN0dJ40DON_q.vbo4t9Z6UCQu3
 e4qa8ch3iI8SPXFyuSuvIXpTXiY1C4vS9qanUqvS8FBtxpj_uUzerP54kfcAwu9lbWhAuS1IiTfU
 LwDYqbtDGgtBayFBSE.1ptvrrqSEw78uvqkgvdE2MSDSu9oUIWX16Zg--
X-Sonic-MF: <alex_y_xu@yahoo.ca>
X-Sonic-ID: c1ca1027-4a5d-4fb6-8760-830c245382b5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.gq1.yahoo.com with HTTP; Wed, 30 Aug 2023 15:52:41 +0000
Received: by hermes--production-bf1-865889d799-xc84r (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0bd111ed5816a0df5a4f025ef033cea4;
          Wed, 30 Aug 2023 15:52:37 +0000 (UTC)
Date:   Wed, 30 Aug 2023 11:52:33 -0400
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: Don't fill the kernel log with memfd_create messages
To:     Christian Brauner <brauner@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Jeff Xu <jeffxu@google.com>,
        Kees Cook <keescook@chromium.org>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        stable@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
MIME-Version: 1.0
Message-Id: <1693408388.rwssx8r1h9.none@localhost>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
References: <1693408388.rwssx8r1h9.none.ref@localhost>
X-Mailer: WebService/1.1.21763 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi all,

Recently "memfd: improve userspace warnings for missing exec-related=20
flags" was merged. On my system, this is a regression, not an=20
improvement, because the entire 256k kernel log buffer (default on x86)=20
is filled with these warnings and "__do_sys_memfd_create: 122 callbacks=20
suppressed". I haven't investigated too closely, but the most likely=20
cause is Wayland libraries.

This is too serious of a consequence for using an old API, especially=20
considering how recently the flags were added. The vast majority of=20
software has not had time to add the flags: glibc does not define the=20
macros until 2.38 which was released less than one month ago, man-pages=20
does not document the flags, and according to Debian Code Search, only=20
systemd, stress-ng, and strace actually pass either of these flags.

Furthermore, since old kernels reject unknown flags, it's not just a=20
matter of defining and passing the flag; every program needs to=20
add logic to handle EINVAL and try again.

Some other way needs to be found to encourage userspace to add the=20
flags; otherwise, this message will be patched out because the kernel=20
log becomes unusable after running unupdated programs, which will still=20
exist even after upstreams are fixed. In particular, AppImages,=20
flatpaks, snaps, and similar app bundles contain vendored Wayland=20
libraries which can be difficult or impossible to update.

Thanks,
Alex.
