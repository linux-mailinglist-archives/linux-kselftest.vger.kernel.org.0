Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77D970BF02
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 May 2023 15:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbjEVNCD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 May 2023 09:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234185AbjEVNBw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 May 2023 09:01:52 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3FB129;
        Mon, 22 May 2023 06:01:47 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-64d2f99c8c3so2375942b3a.0;
        Mon, 22 May 2023 06:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684760507; x=1687352507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S7AZ61ddh8+0XBbzlhbc03FM22aCLhrMtx3Nb3aNYcU=;
        b=GrwKh8UC+7WMW9MKOlsOzyTW/zeV1qPTa7UfYOnG5m3GUX1vjnE3RNKFYB0zzOdRT2
         XkJPBcgim20+unI/2Lvih/HUVRucWf6+CojV/n272lerkxJQPZMWiFt+9Z4OxRJITi7W
         gJM1wk6dQNEmiXZVv1jMVoLA7wEyZGqT6ye/LJlE2maSbrDJrvD7rkyAl2PIHd9tzzqa
         7rzuJjqE+EzvMhsMd/ZRnLD2M/Cii8oXUiLOaQx/HllRXvU32ysQm0O8B+W9adZwwBsq
         LQDlLFgEeW11OL+I1sHehyMVUekCMTJcyDjT9mZpb3jqTp7yRBfBjfdF2BJwFA1wjDsR
         x0Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684760507; x=1687352507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S7AZ61ddh8+0XBbzlhbc03FM22aCLhrMtx3Nb3aNYcU=;
        b=IsatFoqU3nKOu8ALhM4o/DFfbhBzmwJhfVIgliBxCOg6at0mDX82Cmd/+RRMmnQt9c
         eQ0J/dLE4L4WcH1YJku4tPNDr3EWn5lkTg6DtHPumckKNRuLzY9xNEvrgI3jl13vukCQ
         WwbarVrtPugi2EPr34d/H9z+nZB/6z9IU3c71zVivtGLq/v83ZhhaUnRL/9Y0h4bRzmy
         t8H4H86MY5dFyGSIZqlQDePogbVguVsigbJyBwaadkOsf/gE6JfTS0BbkCiuQQPJ8f8F
         atjhzBakevuVS3jE93Zcl6jNX4CuqlrCo8aksFN27scyHADXsf/IXQ7hiW3RISgWC9ry
         Wajg==
X-Gm-Message-State: AC+VfDzFwkrimoudVk44ho9EK8P93VtFsDRW6DH1xsPCS/xx4Q2/Qfry
        DDz1A70ThuDq57HzyV0Q2yM=
X-Google-Smtp-Source: ACHHUZ6rmj8NyHf5qv6+mAaKmfaLdpnKx4z3a/UpRewgqncLy57pD4H+UtRQ+3nzfxHJfhaZAarDGQ==
X-Received: by 2002:a05:6a00:2195:b0:64d:42ca:a4c4 with SMTP id h21-20020a056a00219500b0064d42caa4c4mr10315745pfi.31.1684760506554;
        Mon, 22 May 2023 06:01:46 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-24.three.co.id. [180.214.232.24])
        by smtp.gmail.com with ESMTPSA id i184-20020a6387c1000000b0053ba104c113sm1542349pge.72.2023.05.22.06.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 06:01:46 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 81A8E10698A; Mon, 22 May 2023 20:01:42 +0700 (WIB)
Date:   Mon, 22 May 2023 20:01:41 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Ivan Orlov <ivan.orlov0322@gmail.com>, perex@perex.cz,
        tiwai@suse.com, corbet@lwn.net, broonie@kernel.org,
        skhan@linuxfoundation.org
Cc:     alsa-devel@alsa-project.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        gregkh@linuxfoundation.org, himadrispandya@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2 1/3] docs: sound: add 'pcmtest' driver documentation
Message-ID: <ZGtntdJVy8dZBnf9@debian.me>
References: <20230521183218.9641-1-ivan.orlov0322@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ItcgqONn2GWVCHfj"
Content-Disposition: inline
In-Reply-To: <20230521183218.9641-1-ivan.orlov0322@gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--ItcgqONn2GWVCHfj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 21, 2023 at 10:32:16PM +0400, Ivan Orlov wrote:
> diff --git a/Documentation/sound/cards/pcmtest.rst b/Documentation/sound/=
cards/pcmtest.rst
> new file mode 100644
> index 000000000000..ea8070eaa44e
> --- /dev/null
> +++ b/Documentation/sound/cards/pcmtest.rst
> @@ -0,0 +1,119 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +The Virtual PCM Test Driver
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +
> +The Virtual PCM Test Driver emulates a generic PCM device, and can be us=
ed for
> +testing/fuzzing of the userspace ALSA applications, as well as for testi=
ng/fuzzing of
> +the PCM middle layer. Additionally, it can be used for simulating hard t=
o reproduce
> +problems with PCM devices.
> +
> +What can this driver do?
> +~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +At this moment the driver can do the following things:
> +	* Simulate both capture and playback processes
> +	* Generate random or pattern-based capturing data
> +	* Inject delays into the playback and capturing processes
> +	* Inject errors during the PCM callbacks
> +
> +It supports up to 8 substreams and 4 channels. Also it supports both int=
erleaved and
> +non-interleaved access modes.
> +
> +Also, this driver can check the playback stream for containing the prede=
fined pattern,
> +which is used in the corresponding selftest (alsa/test-pcmtest-driver.c)=
=2E To check the
> +PCM middle layer data transferring functionality. Additionally, this dri=
ver redefines
"... corresponding selftest ... to check the ..."
> +the default RESET ioctl, and the selftest covers this PCM API functional=
ity as well.
> +
> +Configuration
> +-------------
> +
> +The driver has several parameters besides the common ALSA module paramet=
ers:
> +
> +	* fill_mode (bool) - Buffer fill mode (see below)
> +	* inject_delay (int)
> +	* inject_hwpars_err (bool)
> +	* inject_prepare_err (bool)
> +	* inject_trigger_err (bool)
> +
> +
> +Capture Data Generation
> +-----------------------
> +
> +The driver has two modes of data generation: the first (0 in the fill_mo=
de parameter)
> +means random data generation, the second (1 in the fill_mode) - pattern-=
based
> +data generation. Let's look at the second mode.
> +
> +First of all, you may want to specify the pattern for data generation. Y=
ou can do it
> +by writing the pattern to the debugfs file (/sys/kernel/debug/pcmtest/fi=
ll_pattern).
> +Like that:
"For example::"
> +
> +.. code-block:: bash
> +
> +	echo -n mycoolpattern > /sys/kernel/debug/pcmtest/fill_pattern
> +
> +After this, every capture action performed on the 'pcmtest' device will =
return
> +'mycoolpatternmycoolpatternmycoolpatternmy...' for every channel buffer.
> +
> +In case of interleaved access, the capture buffer will contain the repea=
ted pattern
> +for every channel. Otherwise, every channel buffer will contain the repe=
ated pattern.
> +
> +The pattern itself can be up to 4096 bytes long.
> +
> +Delay injection
> +---------------
> +
> +The driver has 'inject_delay' parameter, which has very self-descriptive=
 name and
> +can be used for time delay/speedup simulations. The parameter has intege=
r type, and
> +it means the delay added between module's internal timer ticks.
> +
> +If the 'inject_delay' value is positive, the buffer will be filled slowe=
r, if it is
> +negative - faster. You can try it yourself by starting a recording in any
> +audio recording application (like Audacity) and selecting the 'pcmtest' =
device as a
> +source.
> +
> +This parameter can be also used for generating a huge amount of sound da=
ta in a very
> +short period of time (with the negative 'inject_delay' value).
> +
> +Errors injection
> +----------------
> +
> +This module can be used for injecting errors into the PCM communication =
process. This
> +action can help you to figure out how the userspace ALSA program behaves=
 under unusual
> +circumstances.
> +
> +For example, you can make all 'hw_params' PCM callback calls return EBUS=
Y error by
> +writing '1' to the 'inject_hwpars_err' module parameter:
> +
> +.. code-block:: bash
> +
> +	echo 1 > /sys/module/snd_pcmtest/parameters/inject_hwpars_err
> +
> +Errors can be injected into the following PCM callbacks:
> +
> +	* hw_params (EBUSY)
> +	* prepare (EINVAL)
> +	* trigger (EINVAL)
> +
> +
> +Playback test
> +-------------
> +
> +This driver can be also used for the playback functionality testing - ev=
ery time you
> +write the playback data to the 'pcmtest' PCM device and close it, the dr=
iver checks the
> +buffer of each channel for containing the looped pattern (which is speci=
fied in the
> +fill_pattern debugfs file). If the playback buffer content represents th=
e looped pattern,
> +'pc_test' debugfs entry is set into '1'. Otherwise, the driver sets it t=
o '0'.
> +
> +ioctl redefinition test
> +-----------------------
> +
> +The driver redefines the 'reset' ioctl, which is default for all PCM dev=
ices. To test
> +this functionality, we can trigger the reset ioctl and check the 'ioctl_=
test' debugfs
> +entry:
> +
> +.. code-block:: bash
> +
> +	cat /sys/kernel/debug/pcmtest/ioctl_test
> +
> +If the ioctl is triggered successfully, this file will contain '1', and =
'0' otherwise.

The rest is LGTM, thanks!

--=20
An old man doll... just what I always wanted! - Clara

--ItcgqONn2GWVCHfj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZGtnsQAKCRD2uYlJVVFO
owWSAQDa3xPhRGqPWNO47ow8X1ABw/QyWgrhIsOiEFciBtjyMgEA4q+43FQm55/k
dmpe05/Y6u9YgpC4SHRaNPX/YYt5LQU=
=C2E/
-----END PGP SIGNATURE-----

--ItcgqONn2GWVCHfj--
