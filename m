Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1ED66EC820
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Apr 2023 10:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjDXIwu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Apr 2023 04:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjDXIws (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Apr 2023 04:52:48 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515BE193;
        Mon, 24 Apr 2023 01:52:43 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Q4f4w3rg2zKv7Y;
        Mon, 24 Apr 2023 16:51:44 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 24 Apr 2023 16:52:40 +0800
Message-ID: <5fc97b5b-e76f-99c7-7314-6bb16851f66e@huawei.com>
Date:   Mon, 24 Apr 2023 16:52:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH -next v2 0/6] landlock: add chmod and chown support
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
        <shuah@kernel.org>, <corbet@lwn.net>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <roberto.sassu@huawei.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
References: <20220827111215.131442-1-xiujianfeng@huawei.com>
 <d55baf4d-01d3-e4d7-e07f-9658d1606a8c@huawei.com>
 <a4dc7c12-b485-2eb2-add5-4f7a387a50fa@digikod.net>
From:   xiujianfeng <xiujianfeng@huawei.com>
Content-Language: en-US
In-Reply-To: <a4dc7c12-b485-2eb2-add5-4f7a387a50fa@digikod.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.112]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 2023/4/21 1:40, Mickaël Salaün wrote:
> 
> On 18/04/2023 12:53, xiujianfeng wrote:
>> Hi Mickael,
>>
>> Sorry about the long silence on this work, As we known this work depends
>> on another work about changing argument from struct dentry to struct
>> path for some attr/xattr related lsm hooks, I'm stuck with this thing,
>> because IMA/EVM is a special security module which is not LSM-based
>> currently, and severely coupled with the file system. so I am waiting
>> for Roberto Sassu' work (Move IMA and EVM to the LSM infrastructure) to
>> be ready, I think it can make my work more easy. you can find
>> Roberto'work here,
>> https://lwn.net/ml/linux-kernel/20230303181842.1087717-1-roberto.sassu@huaweicloud.com/
>>
>> Any good idea are welcome, thanks.
> 
> Thanks for the update Xiu.
> 
> Which part would be needed from Roberto's patch series?
> 
As we discussed before, the two access rights that need to be added and
their usage is as below:
LANDLOCK_ACCESS_FS_WRITE_METADATA controls
1.inode_setattr
2.inode_setxattr
3.inode_removexattr
4.inode_set_acl
5.inode_remove_acl
LANDLOCK_ACCESS_FS_READ_METADATA controls
1.inode_getattr
2.inode_get_acl
3.inode_getxattr
4.inode_listxattr

all these APIs should be changed to use struct path instead of dentry,
and then several vfs APIs as follows are invovled:
notify_change,
__vfs_setxattr_locked,
__vfs_removexattr_locked,
__vfs_setxattr_noperm
vfs_set_acl
vfs_remove_acl
vfs_getxattr
vfs_listxattr
vfs_get_acl
and also include some LSM hooks such as inode_post_setxattr and
inode_setsecctx.

Since the original places where pass dentry to security_inode_xxx may
not have any struct path, we have to pass it from the top caller, so
this also touches lots of filesystems(e.g. cachefiles, ecryptfs, ksmbd,
nfsd, overlayfs...).

Other LSMs such as selinux, smack can be easy to refator because they
are LSM-based, and if VFS passes path to security_inode_xxx and they can
just use path->dentry instead inside they own modules.

AS for IMA/EVM, unfortunately they are not LSM-based and coupled with
the file system. To make things worse, there is a recursive dependency
situation during the update of extended attribute which happen as follows:

__vfs_setxattr_noperm
  => security_inode_post_setxattr
    => evm_inode_post_setxattr
      => evm_update_evmxattr
=> __vfs_setxattr_noperm

To change the argument of __vfs_setxattr_noperm from a dentry to the
path structure, the two EVM functions would have to be altered as well.
However, evm_update_evmxattr is called by 3 other EVM functions who
lives in the very heart of the complicated EVM framework. Any change to
them would cause a nasty chain reaction in EVM and, as IMA would trigger
EVM directly, in IMA as well.

There is another callchain as follow:
ima_appraise_measurement
  =>evm_verifyxattr
    =>evm_verifyxattr
      =>evm_verify_hmac
	=>evm_calc_hash
	   =>evm_calc_hmac_or_hash
	     =>vfs_getxattr
Passing struct path into vfs_getxattr() would also affect this
callchain. Currently ima_appraise_measurment accepts a struct file, and
dentry is generated from file_dentry(file) in order to mitigate a
deadlock issue involving overlayfs(commit e71b9dff0634ed). Once
&file->f_path is passed through this callchain, and someone wants the
dentry, it will be using file->f_path.dentry, which is different from
file_dentry(file). In the overlayfs scenario, may this cause an issue?

The patchset of moving IMA and EVM into the LSM infrastructe would be
helpfull but still can not completely resolve this situation. more
refactor would be needed in EVM. That's all that's happening right now.

> 
>>
>>
>> On 2022/8/27 19:12, Xiu Jianfeng wrote:
>>> v2:
>>>   * abstract walk_to_visible_parent() helper
>>>   * chmod and chown rights only take affect on directory's context
>>>   * add testcase for fchmodat/lchown/fchownat
>>>   * fix other review issues
>>>
>>> Xiu Jianfeng (6):
>>>    landlock: expand access_mask_t to u32 type
>>>    landlock: abstract walk_to_visible_parent() helper
>>>    landlock: add chmod and chown support
>>>    landlock/selftests: add selftests for chmod and chown
>>>    landlock/samples: add chmod and chown support
>>>    landlock: update chmod and chown support in document
>>>
>>>   Documentation/userspace-api/landlock.rst     |   9 +-
>>>   include/uapi/linux/landlock.h                |  10 +-
>>>   samples/landlock/sandboxer.c                 |  13 +-
>>>   security/landlock/fs.c                       | 110 ++++++--
>>>   security/landlock/limits.h                   |   2 +-
>>>   security/landlock/ruleset.h                  |   2 +-
>>>   security/landlock/syscalls.c                 |   2 +-
>>>   tools/testing/selftests/landlock/base_test.c |   2 +-
>>>   tools/testing/selftests/landlock/fs_test.c   | 267 ++++++++++++++++++-
>>>   9 files changed, 386 insertions(+), 31 deletions(-)
>>>
