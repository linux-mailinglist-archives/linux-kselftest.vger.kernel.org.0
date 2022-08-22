Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204B459C8E5
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Aug 2022 21:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238686AbiHVTcB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Aug 2022 15:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239147AbiHVTa6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Aug 2022 15:30:58 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7DA1DA69;
        Mon, 22 Aug 2022 12:26:41 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id h22so12954744ejk.4;
        Mon, 22 Aug 2022 12:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=34B6ZerjP73aR6id6f0RzGACZQ2hivLWBiIjVWGXY18=;
        b=Sw7nurMhQNzh2Ro2WO/7hDZvbDJWnymb8aEHmWyPcPtzZFf0xh55xykAysGabanPx8
         bwR3E9cvmCjyv5skEtJrII0H5kSOQZ98reJCYQz2sGAlF85pQLWHILn2iXDAyLcjLC23
         G+pxFizeSoyncxtrvkY0d8xy8kFYIsAXgClTe+RH79TF+nE5WdDdWK18MF9a6O/QvvZF
         r6muGcUzeasHJAh3E4obaF6CDJyBtA9kt/NdSuWS+bO2mMZhnGoFHeH02NGnT0T7RSTG
         MplNH/KyclIsIiMODOxj+WHkvBbRMLMeoAxOVzb4++n8wAewuL+8lsBAJjQZhvGWBvHE
         zHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=34B6ZerjP73aR6id6f0RzGACZQ2hivLWBiIjVWGXY18=;
        b=7Df5sUivcSgfTO70xiKLYx+c+aZASqKm7gYio1PqP9aECMbImJAxtNr6Mmof7vOTbu
         0DRJtIa3IcEK93enl48f8M0Oo69uWVqhgMRNx32Uedug0GKr5oeR5kc4JMmS01HSikKo
         koHlRl3xDzjGFXY0X9D4XJcJLJWw+Ayx/Hyv7uFo+95fXla6u8lQ1Ax10VLkqA7HiaG/
         nY6sxiUQHLDQI9x/6XPLm54UHf14A9ez8i2+6EtLqVDUnW/AUPdc9lIgAh3xk9ZtLGxs
         p5NuCQroOUxyp169lVYEiYyoLJr5Oukc+ko0Y05e/K2Jv40WR60EUwVqo9exIvlr5bf0
         j4Xg==
X-Gm-Message-State: ACgBeo0wsD8gjCjj2qyNSUQIZcOMbPqePkf/4ZkwHavJhJpplv7uhj2u
        xLbFYp86TKuZeKVXnbzHzzc=
X-Google-Smtp-Source: AA6agR7IwMlgtrcN3HByLXR3b2uPu3TTKrTqwjGyDMZq9RruqDF1DlexxH1hQj9n0MYiZP/6PDBqnw==
X-Received: by 2002:a17:907:a056:b0:73d:5b60:5aae with SMTP id gz22-20020a170907a05600b0073d5b605aaemr9173089ejc.238.1661196399927;
        Mon, 22 Aug 2022 12:26:39 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id z22-20020a170906435600b007308812ce89sm6611027ejm.168.2022.08.22.12.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 12:26:39 -0700 (PDT)
Date:   Mon, 22 Aug 2022 21:26:37 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     mic@digikod.net, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, shuah@kernel.org, corbet@lwn.net,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH -next 3/5] landlock/selftests: add selftests for chmod
 and chown
Message-ID: <YwPYbY/HbHTOv7Ux@nuc>
References: <20220822114701.26975-1-xiujianfeng@huawei.com>
 <20220822114701.26975-4-xiujianfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822114701.26975-4-xiujianfeng@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 22, 2022 at 07:46:59PM +0800, Xiu Jianfeng wrote:
> +TEST_F_FORK(layout1, unhandled_chmod)
> +{
> +	const struct rule rules[] = {
> +		{
> +			.path = file2_s3d1,
> +			.access = LANDLOCK_ACCESS_FS_READ_FILE |
> +				  LANDLOCK_ACCESS_FS_WRITE_FILE,
> +		},
> +		{
> +			.path = file3_s3d1,
> +			.access = LANDLOCK_ACCESS_FS_READ_FILE |
> +				  LANDLOCK_ACCESS_FS_WRITE_FILE,
> +		},
> +		{},
> +	};
> +	const int ruleset_fd =
> +		create_ruleset(_metadata, ACCESS_RW, rules);
> +
> +	ASSERT_LE(0, ruleset_fd);
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	ASSERT_EQ(0, close(ruleset_fd));
> +
> +	ASSERT_EQ(0, test_chmod(file2_s3d1));
> +	ASSERT_EQ(0, test_fchmod(file2_s3d1));
> +	ASSERT_EQ(0, test_chmod(file3_s3d1));
> +	ASSERT_EQ(0, test_chmod(dir_s3d1));
> +}

I missed it in the previous mail:

There are also the chown variants lchown() and fchownat(), as well as
the chmod variant fchmodat(), which might be interesting to test,
especially the symlink scenarios.

fchmodat() has a AT_SYMLINK_NOFOLLOW flag which does the chmod
equivalent to lchown().

--
