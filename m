Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5435A38F3
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Aug 2022 18:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbiH0Q6E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 27 Aug 2022 12:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbiH0Q6D (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 27 Aug 2022 12:58:03 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C0D59250;
        Sat, 27 Aug 2022 09:58:01 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id b5so5242273wrr.5;
        Sat, 27 Aug 2022 09:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=R8/bF5KHLjTt9GLEnmNnJrfmlxn+HrK5JbBv33yEUFg=;
        b=W4DsfOUo7kKFGo7dVPXf0A9z/bKIKPbGdjgVun0Q2pPxb+6oybEGLtuAk5nqHI8Uql
         xTBMozGCA9RRFp4mcWnafvbNyeGx1Q92B142WdY3yImSz9TKkdl7O08y7irg/aLAubrm
         lcfvbV8UIJ76iHZRoo557DhYHLf5YQxzIdUl+oWyL5xUk+zWp2aIcWvjwcIV208biuaW
         QQVdQwaNRRkiUndjx7EB6rsyCMF92jmD/7nO2WtEA8wF4C31swCdsshyo1DLiI53VX3t
         rzDGhqO1l8A4csN92AcBM0+dhs0/mxvH0HOumnGOCl1S2xQyRMU0ZhSVUw0SwTZAMrIW
         EVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=R8/bF5KHLjTt9GLEnmNnJrfmlxn+HrK5JbBv33yEUFg=;
        b=vtqzz7lCaxM2zcXy1erSPyXtTQpspd7GAQo906mGepeI0T7WiFW4XGz2Z70azrl6Xp
         8993V4YyBaVe/OcS4BWXbnVcdV/ZfIYZjXl+K4iRtstFomBeohwhjZfN6yqdZVwTA40L
         dynzb6j5q0XWl6wTSukludSdNb8mXBPbpGLxNCwEsgmELsklUBO5c1owoCx2BXttSh6M
         R8xgGOKkFCbIY56a+EyURftIM5H21h1n7exD2aFqHPTNS7giUtgFF7mdYnHq7i7QPLrW
         o68gu+ONtID5O/UROMiAhs4iwV8xs/VUseo0yFWe3KlK2ZcCbiKMGknW1lVPSUwA1zlp
         ZJeQ==
X-Gm-Message-State: ACgBeo3U39nZKgAhLsY/BifUIzAlitAPmYegQyX98gxGIHFJx0Dwm158
        AlNPsVtAxvWmEGGRw37uUOYMsIv6+iE=
X-Google-Smtp-Source: AA6agR6UjKEFuzwxXRJQ8K7HktrS0FN9VJTqTixMwsekgRMuos7HeIk6TxzL0FmvmlvvYedZB016Kg==
X-Received: by 2002:adf:e0c3:0:b0:226:d598:85ee with SMTP id m3-20020adfe0c3000000b00226d59885eemr405190wri.589.1661619479950;
        Sat, 27 Aug 2022 09:57:59 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id x3-20020a05600c420300b003a5bd9448e5sm3111585wmh.28.2022.08.27.09.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 09:57:59 -0700 (PDT)
Date:   Sat, 27 Aug 2022 18:57:57 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     xiujianfeng <xiujianfeng@huawei.com>
Cc:     mic@digikod.net, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, shuah@kernel.org, corbet@lwn.net,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH -next 3/5] landlock/selftests: add selftests for chmod
 and chown
Message-ID: <YwpNFWB9ELDLNLA1@nuc>
References: <20220822114701.26975-1-xiujianfeng@huawei.com>
 <20220822114701.26975-4-xiujianfeng@huawei.com>
 <YwPYbY/HbHTOv7Ux@nuc>
 <64b93d8e-f2b0-31c8-0736-3194053de687@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <64b93d8e-f2b0-31c8-0736-3194053de687@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Aug 27, 2022 at 07:14:30PM +0800, xiujianfeng wrote:
> Hi，
>
> 在 2022/8/23 3:26, Günther Noack 写道:
> > On Mon, Aug 22, 2022 at 07:46:59PM +0800, Xiu Jianfeng wrote:
> > > +TEST_F_FORK(layout1, unhandled_chmod)
> > > +{
> > > +	const struct rule rules[] = {
> > > +		{
> > > +			.path = file2_s3d1,
> > > +			.access = LANDLOCK_ACCESS_FS_READ_FILE |
> > > +				  LANDLOCK_ACCESS_FS_WRITE_FILE,
> > > +		},
> > > +		{
> > > +			.path = file3_s3d1,
> > > +			.access = LANDLOCK_ACCESS_FS_READ_FILE |
> > > +				  LANDLOCK_ACCESS_FS_WRITE_FILE,
> > > +		},
> > > +		{},
> > > +	};
> > > +	const int ruleset_fd =
> > > +		create_ruleset(_metadata, ACCESS_RW, rules);
> > > +
> > > +	ASSERT_LE(0, ruleset_fd);
> > > +	enforce_ruleset(_metadata, ruleset_fd);
> > > +	ASSERT_EQ(0, close(ruleset_fd));
> > > +
> > > +	ASSERT_EQ(0, test_chmod(file2_s3d1));
> > > +	ASSERT_EQ(0, test_fchmod(file2_s3d1));
> > > +	ASSERT_EQ(0, test_chmod(file3_s3d1));
> > > +	ASSERT_EQ(0, test_chmod(dir_s3d1));
> > > +}
> >
> > I missed it in the previous mail:
> >
> > There are also the chown variants lchown() and fchownat(), as well as
> > the chmod variant fchmodat(), which might be interesting to test,
> > especially the symlink scenarios.
> >
> > fchmodat() has a AT_SYMLINK_NOFOLLOW flag which does the chmod
> > equivalent to lchown().
> >
>
> man fchmodat shows as follows:
> ...
> AT_SYMLINK_NOFOLLOW
> If pathname is a symbolic link, do not dereference it: instead operate on
> the link itself. This flag is not currently implemented.
> ...
>
> so I suppose this can not be test. Please correct me if I am wrong.

Good point - I didn't realize that AT_SYMLINK_NOFOLLOW was not
implemented for fchmodat. In that case, this only applies to lchown.

—Günther

--
