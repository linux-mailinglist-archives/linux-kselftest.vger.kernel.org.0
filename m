Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C3555D071
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jun 2022 15:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237514AbiF0S6V (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Jun 2022 14:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239147AbiF0S5P (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Jun 2022 14:57:15 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467A410C0;
        Mon, 27 Jun 2022 11:57:14 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id o43so16179005qvo.4;
        Mon, 27 Jun 2022 11:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NOsgPwcDx+OihP7CM9EgDPr6TtruXCYq9aRNj46ysBQ=;
        b=m2eUHMAtpzvN+Y99ePVbPBQhAiBwfdEMa4sYWEHf2vtSBRaVt/SObAY73NbhrfVRfT
         bIAQti3EBUREmLes+VGyWRM/whbdbjPFFIuDU/j3NkDwPE/jOD3NueZzE82yw60Vs2Yc
         3a8s7Yt92kyWFupcn49IGDFq2DfzziTMaUL/KsaDcRlQ+mv5JEU1/Z8gxzeJP5Mq7INE
         mZyZpzrs+NVF5UJ38AiWA7JgBQu6LWX5NqeYEMPyHcLd7m4ZvXM1mtntv9xK71DmrCJV
         3PLqp6sEguoeleMa70eC8OzsTFBtGVG58Kmve2RhNwey7dXpIv6CFExpLh+oqa94Vqkr
         UQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NOsgPwcDx+OihP7CM9EgDPr6TtruXCYq9aRNj46ysBQ=;
        b=UArkldCLlMklvJThRGaV1iFIU37IuNO49rJpecn5qfXZXTUD6pRq2B7CwxbGnrG0ds
         5KHd44Rb37K0rkxm22jIYfxriQskVmkDfES/s2tktMem3bQHUOw0zukLkJH6cbyyeQAo
         XH0Vxc0anyNZdhjtw9KH2pfBb4lCb5jn4Q73mFyReNXsWBdbcbM6T+82GT+oiYqb6yrt
         GHWFmzCP8RwehHM4hGw0vPeU3INTD1HLq7f5Ue8wSuLidz/bn/y21hQ8AJIESykM7pEG
         37HLP+pm9cTC2DxdMPa/5ZDaWgHw/JeUxfT5+CMW9eN3aRFLlKNpefDuWJkvT99spFRT
         lliw==
X-Gm-Message-State: AJIora8HdfwZmjWdpzjaD8hSFTdNAkbzozqBxtWhR9xjKClISFSiC9aB
        194GXnxkZFprlbYdqQ0R9yo=
X-Google-Smtp-Source: AGRyM1v5DGJwQQuAEAEZGEeHt/yRbP+et2CeJtdJxfhZdyXi1ntL/oaNsKV7SbYf8pRvXiM6V6UuHQ==
X-Received: by 2002:a0c:9a0e:0:b0:470:5ffa:ff43 with SMTP id p14-20020a0c9a0e000000b004705ffaff43mr745456qvd.6.1656356233274;
        Mon, 27 Jun 2022 11:57:13 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id g1-20020ac87f41000000b002f93554c009sm7781826qtk.59.2022.06.27.11.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 11:57:12 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Gautam <gautammenghani201@gmail.com>, shuah@kernel.org,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] kselftests/damon: add support for cases where debugfs cannot be read
Date:   Mon, 27 Jun 2022 18:57:04 +0000
Message-Id: <20220627185704.58902-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <7d6b7de6-4609-e6ca-0a88-1f9799c70769@linuxfoundation.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: SeongJae Park <sj@kernel.org>

Hi Shuah,

On Mon, 27 Jun 2022 11:00:18 -0600 Shuah Khan <skhan@linuxfoundation.org> wrote:

[...]
> >> --- a/tools/testing/selftests/damon/_chk_dependency.sh
> >> +++ b/tools/testing/selftests/damon/_chk_dependency.sh
> >> @@ -26,3 +26,13 @@ do
> >>   		exit 1
> >>   	fi
> >>   done
> >> +
> >> +permission_error="Operation not permitted"
> >> +for f in attrs target_ids monitor_on
> >> +do
> >> +	status=$( cat "$DBGFS/$f" 2>&1 )
> >> +	if [ "${status#*$permission_error}" != "$status" ]; then
> >> +		echo "Permission for reading $DBGFS/$f denied; maybe secureboot enabled?"
> 
> btw - does this run as a regular user or does it need root privilege?
> If so add a test for that and skip with a message.

It needs the root permission, and does the check at the beginning[1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/damon/_chk_dependency.sh?h=v5.19-rc4#n9


Thanks,
SJ

> >> +		exit $ksft_skip
> >> +	fi
> >> +done
> >> -- 
> >> 2.36.1
> >
> thanks,
> -- Shuah
