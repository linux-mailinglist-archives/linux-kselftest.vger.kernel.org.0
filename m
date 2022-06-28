Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA7955C722
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jun 2022 14:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243279AbiF1DhY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Jun 2022 23:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243263AbiF1DhT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Jun 2022 23:37:19 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E38824F0B;
        Mon, 27 Jun 2022 20:37:18 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id x1-20020a17090abc8100b001ec7f8a51f5so14545730pjr.0;
        Mon, 27 Jun 2022 20:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G2ZI6aMz7mjHuacv2TpkSw0NDmBUe+64bYW0SIydJ1c=;
        b=qWSblFa8OsXeRRuOE0A/MhNHBxZKjTtnAjA3B92NuHrFB/xQ73Fq7JAKZUSMerimfT
         lBSSFX/cc7HP+4o4G7SOWtrqiLpi4rHj+7ziQmJ35u3jjOOm2e9ac+evtsQMtVrwuZ1h
         a9SX3SXZu+eo1UC2XDtg2s/Pu83GBvFAdf4C/tWCKkcVqS6taZRukb8hRGey3TmfV0HB
         FcJRkmGlhU9w+CtES91WezFc/koimMNnM+sIWw0Uv8lVDjCBwiKzsnwM45X25OQhTS9/
         2ZwjgfwJMOEVBvLs5Xii9V84Y6XJDH2AP4+l1Va9ssEOCMJ7YbT6u9tnFbHhGz7+/q+a
         CCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G2ZI6aMz7mjHuacv2TpkSw0NDmBUe+64bYW0SIydJ1c=;
        b=1XfD09bXED5IvhCs0K8qkQNjYUR79k1eMB4BPXi1b0CCI5GTPnw1dEu8qsKqUk4vA+
         Nj+215lWmHtkn+ipP5udkK3PW5s1iQl/JOOquaVtKlixfYzR/uR1oT84kdLk7mrALZDO
         K2cbmGHK9BzTyo8+xGt/XbZABJlN3DsFa8XY/J/rTpp3PvqiZYYIcrQoOofeioLAZhE4
         2hHdH3xsgPSVVGNKNPcJvJk+CBcV2IdkjMIs6Kvw14rgGWRMal19EcivyTM8nTzWGvbM
         R8Imjh53GW/LJsdGDo3Bk6rSsSr/VY8OjtBNYK4ELv2r+B+0qplm11PmU1Y+pjqnVANo
         mPNQ==
X-Gm-Message-State: AJIora+hxluwgSu3RiYe1R3Y8LDuK6xX/ztrYfvsTcVybCS8jln8OuGT
        twfdlhoiaYymHII3Lp6OMrQ=
X-Google-Smtp-Source: AGRyM1v/JF9sZ/ij650I5WlKuyttuPJ8uAaz2+f1pjdmNhjhPRS105MXj2fjZLNNlVjiJJn/+TK2KA==
X-Received: by 2002:a17:90a:aa96:b0:1ea:3780:c3dc with SMTP id l22-20020a17090aaa9600b001ea3780c3dcmr25121973pjq.241.1656387437966;
        Mon, 27 Jun 2022 20:37:17 -0700 (PDT)
Received: from fedora ([103.230.148.187])
        by smtp.gmail.com with ESMTPSA id im22-20020a170902bb1600b0016a3f9e528asm2912212plb.57.2022.06.27.20.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 20:37:16 -0700 (PDT)
Date:   Tue, 28 Jun 2022 09:07:11 +0530
From:   Gautam Menghani <gautammenghani201@gmail.com>
To:     sj@kernel.org
Cc:     skhan@linuxfoundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] kselftests/damon: add support for cases where debugfs
 cannot be read
Message-ID: <Yrp3ZwF4Q/xPDrwG@fedora>
References: <20220625200334.83818-1-sj@kernel.org>
 <7d6b7de6-4609-e6ca-0a88-1f9799c70769@linuxfoundation.org>
 <Yrn6BxU298rzjiak@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yrn6BxU298rzjiak@fedora>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Cc'ing everyone as I forgot to group reply before. Also, I have included the 
example outputs in this reply.
On Tue, Jun 28, 2022 at 12:12:15AM +0530, Gautam Menghani wrote:
> On Mon, Jun 27, 2022 at 11:00:18AM -0600, Shuah Khan wrote:
> > On 6/25/22 2:03 PM, SeongJae Park wrote:
> > > Hi Gautam,
> > > 
> > > On Sun, 26 Jun 2022 01:22:45 +0530 Gautam <gautammenghani201@gmail.com> wrote:
> > > 
> > > > The kernel is in lockdown mode when secureboot is enabled and hence
> > > > debugfs cannot be used. Add support for this and other general cases
> > > > where debugfs cannot be read and communicate the same to the user before
> > > > running tests.
> > > > 
> > > > Signed-off-by: Gautam <gautammenghani201@gmail.com>
> > > 
> > > Reviewed-by: SeongJae Park <sj@kernel.org>
> > > 
> > > 
> > > Thanks,
> > > SJ
> > > 
> > > > ---
> > > > Changes in v2:
> > > > 1. Modify the error message to account for general cases.
> > > > 2. Change the return code so that the test is skipped.
> > > > 
> > > > Changes in v3:
> > > > 1. Change the name of variable holding the error message.
> > > > 
> > > > Changes in v4:
> > > > 1. Correct the mode of the source file.
> > > > 
> > > >   tools/testing/selftests/damon/_chk_dependency.sh | 10 ++++++++++
> > > >   1 file changed, 10 insertions(+)
> > > > 
> > > > diff --git a/tools/testing/selftests/damon/_chk_dependency.sh b/tools/testing/selftests/damon/_chk_dependency.sh
> > > > index 0189db81550b..0328ac0b5a5e 100644
> > > > --- a/tools/testing/selftests/damon/_chk_dependency.sh
> > > > +++ b/tools/testing/selftests/damon/_chk_dependency.sh
> > > > @@ -26,3 +26,13 @@ do
> > > >   		exit 1
> > > >   	fi
> > > >   done
> > > > +
> > > > +permission_error="Operation not permitted"
> > > > +for f in attrs target_ids monitor_on
> > > > +do
> > > > +	status=$( cat "$DBGFS/$f" 2>&1 )
> > > > +	if [ "${status#*$permission_error}" != "$status" ]; then
> > > > +		echo "Permission for reading $DBGFS/$f denied; maybe secureboot enabled?"
> > 
> > btw - does this run as a regular user or does it need root privilege?
> > If so add a test for that and skip with a message.
> 
> Yes this condition is reachable only with root user. If damon tests are run
> as regular user, the root check condition already skips the tests.
> 
> Tests output as regular user:
> +TAP version 13
> +1..6
> +# selftests: damon: debugfs_attrs.sh
> +# Run as root
> +ok 1 selftests: damon: debugfs_attrs.sh # SKIP
> +# selftests: damon: debugfs_schemes.sh
> +# Run as root
> 
> Tests output as root user:
> +TAP version 13
> +1..6
> +# selftests: damon: debugfs_attrs.sh
> +# Permission for reading /sys/kernel/debug/damon/attrs denied; maybe secureboot enabled?
> +ok 1 selftests: damon: debugfs_attrs.sh # SKIP
> +# selftests: damon: debugfs_schemes.sh
> +# Permission for reading /sys/kernel/debug/damon/attrs denied; maybe secureboot enabled?
> 
> Is any change needed in this patch?
> 
> > > > +		exit $ksft_skip
> > > > +	fi
> > > > +done
> > > > -- 
> > > > 2.36.1
> > > 
> > thanks,
> > -- Shuah
