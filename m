Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A363F52013C
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 May 2022 17:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238348AbiEIPfm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 May 2022 11:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238342AbiEIPfl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 May 2022 11:35:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CED761BE10D
        for <linux-kselftest@vger.kernel.org>; Mon,  9 May 2022 08:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652110306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1FaMWoJISzjN2dwMS/mluzbJYmmCySrPETWgWtF+pfw=;
        b=gb9JRS4umJNdY4aw8DNenPAZf/qS6H3Qx0Y4nifJ2gLibVMpJ3uCUH6zaENaYCrMoIvb7a
        bgi+5Kr9Syayi6kysil9JGOq/N1WUBGOn1CAUJxqfA9b68pciby+IcLsSHIhW+TT4tdjel
        aG++yuLSFZXu0wJqgTSot6VirzyZjRc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-60-PEFLo9Q4PcCpEYY_uO6DAA-1; Mon, 09 May 2022 11:31:44 -0400
X-MC-Unique: PEFLo9Q4PcCpEYY_uO6DAA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 22C58185A7A4;
        Mon,  9 May 2022 15:31:44 +0000 (UTC)
Received: from maya.cloud.tilaa.com (unknown [10.40.208.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E271AC27E83;
        Mon,  9 May 2022 15:31:43 +0000 (UTC)
Date:   Mon, 9 May 2022 17:31:40 +0200
From:   Stefano Brivio <sbrivio@redhat.com>
To:     linux-kselftest@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>,
        Sevinj Aghayeva <sevinj.aghayeva@gmail.com>,
        Roopa Prabhu <roopa@nvidia.com>
Subject: using mbuto to run kselftests
Message-ID: <20220509173140.549db406@elisabeth>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

Thanks to a substantial contribution by Sevinj Aghayeva during the
Outreachy contribution phase, mbuto (a shell script building initramfs
images that can be loaded by qemu) can now be used to conveniently run
kernel selftests in VMs. The website at:

	https://mbuto.sh/

shows examples with kselftests and a link to the man page.

Comments, bug reports and patches are all very welcome!

-- 
Stefano

