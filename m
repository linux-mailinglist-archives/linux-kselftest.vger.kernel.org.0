Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6945AE628
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Sep 2022 13:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239817AbiIFLFc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Sep 2022 07:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239780AbiIFLFb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Sep 2022 07:05:31 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3EB5006A;
        Tue,  6 Sep 2022 04:05:24 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4MMMpr1WGdz9v7Gj;
        Tue,  6 Sep 2022 18:59:48 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwD37pJGKRdj0cYnAA--.38921S2;
        Tue, 06 Sep 2022 12:04:52 +0100 (CET)
Message-ID: <bd7cb49606b6102c5263df94784c850c91434359.camel@huaweicloud.com>
Subject: Re: [PATCH v16 05/12] KEYS: Move KEY_LOOKUP_ to include/linux/key.h
 and define KEY_LOOKUP_ALL
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        dhowells@redhat.com, rostedt@goodmis.org, mingo@redhat.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        shuah@kernel.org, bpf@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        deso@posteo.net, memxor@gmail.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Tue, 06 Sep 2022 13:04:35 +0200
In-Reply-To: <Yxci4yrV5OcMnTNi@kernel.org>
References: <20220905143318.1592015-1-roberto.sassu@huaweicloud.com>
         <20220905143318.1592015-6-roberto.sassu@huaweicloud.com>
         <YxZsbLIAcR4/bScc@kernel.org>
         <394ed3b5f96afd3cf39e99675be1a32c89c8080d.camel@huaweicloud.com>
         <Yxci4yrV5OcMnTNi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwD37pJGKRdj0cYnAA--.38921S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tryDZFy8JFy5JFW3JFyxXwb_yoW8GrW3pF
        WUJan2kFyktr1fAa1DKa43A34Fy39xtr4UX3Z5J34UZF92vr1Y9r1xAa1fuFyqyrWDKF1U
        ArZIqFy7W3WDA37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
        7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
        Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
        6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
        AIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1c4S7UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAHBF1jj4KppwAAs-
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 2022-09-06 at 13:37 +0300, Jarkko Sakkinen wrote:
> On Tue, Sep 06, 2022 at 09:08:23AM +0200, Roberto Sassu wrote:
> > On Tue, 2022-09-06 at 00:38 +0300, Jarkko Sakkinen wrote:
> > > On Mon, Sep 05, 2022 at 04:33:11PM +0200, Roberto Sassu wrote:
> > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > > 
> > > > In preparation for the patch that introduces the
> > > > bpf_lookup_user_key() eBPF
> > > > kfunc, move KEY_LOOKUP_ definitions to include/linux/key.h, to
> > > > be
> > > > able to
> > > > validate the kfunc parameters. Add them to enum
> > > > key_lookup_flag, so
> > > > that
> > > > all the current ones and the ones defined in the future are
> > > > automatically
> > > > exported through BTF and available to eBPF programs.
> > > > 
> > > > Also, add KEY_LOOKUP_ALL to the enum, to facilitate checking
> > > > whether a
> > > > variable contains only defined flags.
> > > > 
> > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > > Reviewed-by: KP Singh <kpsingh@kernel.org>
> > > > Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > 
> > > You should remove ack if there is any substantial change.
> > 
> > Yes, sorry. I thought you were fine with the change due to:
> > 
> > https://lore.kernel.org/bpf/YxF4H9MTDj+PnJ+V@kernel.org/
> 
> It was the documentation part, not really the enum change.
> 

Ok, so if I remove the documentation I can keep your ack?

Thanks

Roberto

