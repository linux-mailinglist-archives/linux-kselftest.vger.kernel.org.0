Return-Path: <linux-kselftest+bounces-7700-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B09468A1487
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 14:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13FCE1F2341E
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 12:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F025A14F121;
	Thu, 11 Apr 2024 12:24:53 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A9B14B09C;
	Thu, 11 Apr 2024 12:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712838293; cv=none; b=C4Svk6Q+qxCYWJbyEyARHoyQiWmoyr5PscHTgCFCYgrx+7q+JpohYin2v0CQeZ0VktVIZoazSIIMt30Qi35krgdq1CPHye5C0isT1j71pV0gnaKb0kau7oa+w72tceNvPR4n7gCLwTCLP6BxB+i76ZmzMziyo9URaxpp8D/OxYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712838293; c=relaxed/simple;
	bh=P/jCyGa1ZU6Abbg/o1UQ1TdKSYUFr7RedwNfT53zLtg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LeIZqSPspMPRqVjg+sAQX9psNW1Zo9YBVYQLaF3YQXj6BkoMuDKl/rW/mLecKh2FNp7ZpQwbzXucMszCL0CrI1if9aSMc+it0N9oyLmunNU2osez7bNhf5xW7Q8CnJ55hCyVOUJE+PzayxY/Ix/sLWZ1KRu9+tTNml0wGLRkCh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VFf5j2XtZz4f3kk3;
	Thu, 11 Apr 2024 20:24:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BDBAB1A0175;
	Thu, 11 Apr 2024 20:24:45 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP4 (Coremail) with SMTP id gCh0CgA3h2mJ1hdmZ5R_Jw--.23051S3;
	Thu, 11 Apr 2024 20:24:45 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Brendan Jackman <jackmanb@chromium.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Khadija Kamran <kamrankhadijadj@gmail.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	John Johansen <john.johansen@canonical.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next v3 01/11] bpf, lsm: Annotate lsm hook return value range
Date: Thu, 11 Apr 2024 20:27:42 +0800
Message-Id: <20240411122752.2873562-2-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240411122752.2873562-1-xukuohai@huaweicloud.com>
References: <20240411122752.2873562-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3h2mJ1hdmZ5R_Jw--.23051S3
X-Coremail-Antispam: 1UD129KBjvAXoWDXrW7WF17ur43Jw17Wry3Arb_yoW7ArW8Wo
	W7K3srur4Fgw18JFW7Gw1fGF93u3srXr1Fyw4DW3s8ZFnrC3srA393JryUXF47Xr45G398
	AFZFy34rZF4kXw1Dn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYX7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr
	4l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
	Av7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAHUDUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

Add macro LSM_RET_INT to annotate lsm hook return integer type and the
default return value, and the expected return range.

The LSM_RET_INT is declared as:

LSM_RET_INT(defval, min, max)

where

- defval is the default return value

- min and max indicate the expected return range is [min, max]

The return value range for each lsm hook is taken from the description
in security/security.c.

The expanded result of LSM_RET_INT is not changed, and the compiled
product is not changed.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 include/linux/lsm_hook_defs.h | 591 +++++++++++++++++-----------------
 include/linux/lsm_hooks.h     |   6 -
 kernel/bpf/bpf_lsm.c          |  10 +
 security/security.c           |   1 +
 4 files changed, 313 insertions(+), 295 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 334e00efbde4..708f515ffbf3 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -18,435 +18,448 @@
  * The macro LSM_HOOK is used to define the data structures required by
  * the LSM framework using the pattern:
  *
- *	LSM_HOOK(<return_type>, <default_value>, <hook_name>, args...)
+ *	LSM_HOOK(<return_type>, <return_description>, <hook_name>, args...)
  *
  * struct security_hook_heads {
- *   #define LSM_HOOK(RET, DEFAULT, NAME, ...) struct hlist_head NAME;
+ *   #define LSM_HOOK(RET, RETVAL_DESC, NAME, ...) struct hlist_head NAME;
  *   #include <linux/lsm_hook_defs.h>
  *   #undef LSM_HOOK
  * };
  */
-LSM_HOOK(int, 0, binder_set_context_mgr, const struct cred *mgr)
-LSM_HOOK(int, 0, binder_transaction, const struct cred *from,
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), binder_set_context_mgr, const struct cred *mgr)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), binder_transaction, const struct cred *from,
 	 const struct cred *to)
-LSM_HOOK(int, 0, binder_transfer_binder, const struct cred *from,
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), binder_transfer_binder, const struct cred *from,
 	 const struct cred *to)
-LSM_HOOK(int, 0, binder_transfer_file, const struct cred *from,
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), binder_transfer_file, const struct cred *from,
 	 const struct cred *to, const struct file *file)
-LSM_HOOK(int, 0, ptrace_access_check, struct task_struct *child,
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), ptrace_access_check, struct task_struct *child,
 	 unsigned int mode)
-LSM_HOOK(int, 0, ptrace_traceme, struct task_struct *parent)
-LSM_HOOK(int, 0, capget, const struct task_struct *target, kernel_cap_t *effective,
-	 kernel_cap_t *inheritable, kernel_cap_t *permitted)
-LSM_HOOK(int, 0, capset, struct cred *new, const struct cred *old,
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), ptrace_traceme, struct task_struct *parent)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), capget, const struct task_struct *target,
+	 kernel_cap_t *effective, kernel_cap_t *inheritable, kernel_cap_t *permitted)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), capset, struct cred *new, const struct cred *old,
 	 const kernel_cap_t *effective, const kernel_cap_t *inheritable,
 	 const kernel_cap_t *permitted)
-LSM_HOOK(int, 0, capable, const struct cred *cred, struct user_namespace *ns,
-	 int cap, unsigned int opts)
-LSM_HOOK(int, 0, quotactl, int cmds, int type, int id, const struct super_block *sb)
-LSM_HOOK(int, 0, quota_on, struct dentry *dentry)
-LSM_HOOK(int, 0, syslog, int type)
-LSM_HOOK(int, 0, settime, const struct timespec64 *ts,
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), capable, const struct cred *cred,
+	 struct user_namespace *ns, int cap, unsigned int opts)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), quotactl, int cmds, int type, int id,
+	 const struct super_block *sb)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), quota_on, struct dentry *dentry)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), syslog, int type)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), settime, const struct timespec64 *ts,
 	 const struct timezone *tz)
-LSM_HOOK(int, 1, vm_enough_memory, struct mm_struct *mm, long pages)
-LSM_HOOK(int, 0, bprm_creds_for_exec, struct linux_binprm *bprm)
-LSM_HOOK(int, 0, bprm_creds_from_file, struct linux_binprm *bprm, const struct file *file)
-LSM_HOOK(int, 0, bprm_check_security, struct linux_binprm *bprm)
+LSM_HOOK(int, LSM_RET_INT(1, INT_MIN, INT_MAX), vm_enough_memory, struct mm_struct *mm, long pages)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), bprm_creds_for_exec, struct linux_binprm *bprm)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), bprm_creds_from_file, struct linux_binprm *bprm,
+	 const struct file *file)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), bprm_check_security, struct linux_binprm *bprm)
 LSM_HOOK(void, LSM_RET_VOID, bprm_committing_creds, const struct linux_binprm *bprm)
 LSM_HOOK(void, LSM_RET_VOID, bprm_committed_creds, const struct linux_binprm *bprm)
-LSM_HOOK(int, 0, fs_context_submount, struct fs_context *fc, struct super_block *reference)
-LSM_HOOK(int, 0, fs_context_dup, struct fs_context *fc,
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), fs_context_submount, struct fs_context *fc,
+	 struct super_block *reference)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), fs_context_dup, struct fs_context *fc,
 	 struct fs_context *src_sc)
-LSM_HOOK(int, -ENOPARAM, fs_context_parse_param, struct fs_context *fc,
+LSM_HOOK(int, LSM_RET_INT(-ENOPARAM, -MAX_ERRNO, 0), fs_context_parse_param, struct fs_context *fc,
 	 struct fs_parameter *param)
-LSM_HOOK(int, 0, sb_alloc_security, struct super_block *sb)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), sb_alloc_security, struct super_block *sb)
 LSM_HOOK(void, LSM_RET_VOID, sb_delete, struct super_block *sb)
 LSM_HOOK(void, LSM_RET_VOID, sb_free_security, struct super_block *sb)
 LSM_HOOK(void, LSM_RET_VOID, sb_free_mnt_opts, void *mnt_opts)
-LSM_HOOK(int, 0, sb_eat_lsm_opts, char *orig, void **mnt_opts)
-LSM_HOOK(int, 0, sb_mnt_opts_compat, struct super_block *sb, void *mnt_opts)
-LSM_HOOK(int, 0, sb_remount, struct super_block *sb, void *mnt_opts)
-LSM_HOOK(int, 0, sb_kern_mount, const struct super_block *sb)
-LSM_HOOK(int, 0, sb_show_options, struct seq_file *m, struct super_block *sb)
-LSM_HOOK(int, 0, sb_statfs, struct dentry *dentry)
-LSM_HOOK(int, 0, sb_mount, const char *dev_name, const struct path *path,
-	 const char *type, unsigned long flags, void *data)
-LSM_HOOK(int, 0, sb_umount, struct vfsmount *mnt, int flags)
-LSM_HOOK(int, 0, sb_pivotroot, const struct path *old_path,
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), sb_eat_lsm_opts, char *orig, void **mnt_opts)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), sb_mnt_opts_compat, struct super_block *sb,
+	 void *mnt_opts)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), sb_remount, struct super_block *sb, void *mnt_opts)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), sb_kern_mount, const struct super_block *sb)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), sb_show_options, struct seq_file *m,
+	 struct super_block *sb)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), sb_statfs, struct dentry *dentry)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), sb_mount, const char *dev_name,
+	 const struct path *path, const char *type, unsigned long flags, void *data)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), sb_umount, struct vfsmount *mnt, int flags)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), sb_pivotroot, const struct path *old_path,
 	 const struct path *new_path)
-LSM_HOOK(int, 0, sb_set_mnt_opts, struct super_block *sb, void *mnt_opts,
-	 unsigned long kern_flags, unsigned long *set_kern_flags)
-LSM_HOOK(int, 0, sb_clone_mnt_opts, const struct super_block *oldsb,
-	 struct super_block *newsb, unsigned long kern_flags,
-	 unsigned long *set_kern_flags)
-LSM_HOOK(int, 0, move_mount, const struct path *from_path,
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), sb_set_mnt_opts, struct super_block *sb,
+	 void *mnt_opts, unsigned long kern_flags, unsigned long *set_kern_flags)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), sb_clone_mnt_opts, const struct super_block *oldsb,
+	 struct super_block *newsb, unsigned long kern_flags, unsigned long *set_kern_flags)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), move_mount, const struct path *from_path,
 	 const struct path *to_path)
-LSM_HOOK(int, -EOPNOTSUPP, dentry_init_security, struct dentry *dentry,
-	 int mode, const struct qstr *name, const char **xattr_name,
-	 void **ctx, u32 *ctxlen)
-LSM_HOOK(int, 0, dentry_create_files_as, struct dentry *dentry, int mode,
-	 struct qstr *name, const struct cred *old, struct cred *new)
+LSM_HOOK(int, LSM_RET_INT(-EOPNOTSUPP, -MAX_ERRNO, 0), dentry_init_security, struct dentry *dentry,
+	 int mode, const struct qstr *name, const char **xattr_name, void **ctx, u32 *ctxlen)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), dentry_create_files_as, struct dentry *dentry,
+	 int mode, struct qstr *name, const struct cred *old, struct cred *new)
 
 #ifdef CONFIG_SECURITY_PATH
-LSM_HOOK(int, 0, path_unlink, const struct path *dir, struct dentry *dentry)
-LSM_HOOK(int, 0, path_mkdir, const struct path *dir, struct dentry *dentry,
-	 umode_t mode)
-LSM_HOOK(int, 0, path_rmdir, const struct path *dir, struct dentry *dentry)
-LSM_HOOK(int, 0, path_mknod, const struct path *dir, struct dentry *dentry,
-	 umode_t mode, unsigned int dev)
-LSM_HOOK(void, LSM_RET_VOID, path_post_mknod, struct mnt_idmap *idmap,
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), path_unlink, const struct path *dir,
+	 struct dentry *dentry)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), path_mkdir, const struct path *dir,
+	 struct dentry *dentry, umode_t mode)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), path_rmdir, const struct path *dir,
 	 struct dentry *dentry)
-LSM_HOOK(int, 0, path_truncate, const struct path *path)
-LSM_HOOK(int, 0, path_symlink, const struct path *dir, struct dentry *dentry,
-	 const char *old_name)
-LSM_HOOK(int, 0, path_link, struct dentry *old_dentry,
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), path_mknod, const struct path *dir,
+	 struct dentry *dentry, umode_t mode, unsigned int dev)
+LSM_HOOK(void, LSM_RET_VOID, path_post_mknod, struct mnt_idmap *idmap, struct dentry *dentry)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), path_truncate, const struct path *path)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), path_symlink, const struct path *dir,
+	 struct dentry *dentry, const char *old_name)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), path_link, struct dentry *old_dentry,
 	 const struct path *new_dir, struct dentry *new_dentry)
-LSM_HOOK(int, 0, path_rename, const struct path *old_dir,
-	 struct dentry *old_dentry, const struct path *new_dir,
-	 struct dentry *new_dentry, unsigned int flags)
-LSM_HOOK(int, 0, path_chmod, const struct path *path, umode_t mode)
-LSM_HOOK(int, 0, path_chown, const struct path *path, kuid_t uid, kgid_t gid)
-LSM_HOOK(int, 0, path_chroot, const struct path *path)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), path_rename, const struct path *old_dir,
+	 struct dentry *old_dentry, const struct path *new_dir, struct dentry *new_dentry,
+	 unsigned int flags)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), path_chmod, const struct path *path, umode_t mode)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), path_chown, const struct path *path, kuid_t uid,
+	 kgid_t gid)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), path_chroot, const struct path *path)
 #endif /* CONFIG_SECURITY_PATH */
 
 /* Needed for inode based security check */
-LSM_HOOK(int, 0, path_notify, const struct path *path, u64 mask,
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), path_notify, const struct path *path, u64 mask,
 	 unsigned int obj_type)
-LSM_HOOK(int, 0, inode_alloc_security, struct inode *inode)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), inode_alloc_security, struct inode *inode)
 LSM_HOOK(void, LSM_RET_VOID, inode_free_security, struct inode *inode)
-LSM_HOOK(int, -EOPNOTSUPP, inode_init_security, struct inode *inode,
-	 struct inode *dir, const struct qstr *qstr, struct xattr *xattrs,
-	 int *xattr_count)
-LSM_HOOK(int, 0, inode_init_security_anon, struct inode *inode,
+LSM_HOOK(int, LSM_RET_INT(-EOPNOTSUPP, -MAX_ERRNO, 0), inode_init_security, struct inode *inode,
+	 struct inode *dir, const struct qstr *qstr, struct xattr *xattrs, int *xattr_count)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), inode_init_security_anon, struct inode *inode,
 	 const struct qstr *name, const struct inode *context_inode)
-LSM_HOOK(int, 0, inode_create, struct inode *dir, struct dentry *dentry,
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), inode_create, struct inode *dir, struct dentry *dentry,
 	 umode_t mode)
 LSM_HOOK(void, LSM_RET_VOID, inode_post_create_tmpfile, struct mnt_idmap *idmap,
 	 struct inode *inode)
-LSM_HOOK(int, 0, inode_link, struct dentry *old_dentry, struct inode *dir,
-	 struct dentry *new_dentry)
-LSM_HOOK(int, 0, inode_unlink, struct inode *dir, struct dentry *dentry)
-LSM_HOOK(int, 0, inode_symlink, struct inode *dir, struct dentry *dentry,
-	 const char *old_name)
-LSM_HOOK(int, 0, inode_mkdir, struct inode *dir, struct dentry *dentry,
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), inode_link, struct dentry *old_dentry,
+	 struct inode *dir, struct dentry *new_dentry)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), inode_unlink, struct inode *dir, struct dentry *dentry)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), inode_symlink, struct inode *dir,
+	 struct dentry *dentry, const char *old_name)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), inode_mkdir, struct inode *dir, struct dentry *dentry,
 	 umode_t mode)
-LSM_HOOK(int, 0, inode_rmdir, struct inode *dir, struct dentry *dentry)
-LSM_HOOK(int, 0, inode_mknod, struct inode *dir, struct dentry *dentry,
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), inode_rmdir, struct inode *dir, struct dentry *dentry)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), inode_mknod, struct inode *dir, struct dentry *dentry,
 	 umode_t mode, dev_t dev)
-LSM_HOOK(int, 0, inode_rename, struct inode *old_dir, struct dentry *old_dentry,
-	 struct inode *new_dir, struct dentry *new_dentry)
-LSM_HOOK(int, 0, inode_readlink, struct dentry *dentry)
-LSM_HOOK(int, 0, inode_follow_link, struct dentry *dentry, struct inode *inode,
-	 bool rcu)
-LSM_HOOK(int, 0, inode_permission, struct inode *inode, int mask)
-LSM_HOOK(int, 0, inode_setattr, struct mnt_idmap *idmap, struct dentry *dentry,
-	 struct iattr *attr)
-LSM_HOOK(void, LSM_RET_VOID, inode_post_setattr, struct mnt_idmap *idmap,
-	 struct dentry *dentry, int ia_valid)
-LSM_HOOK(int, 0, inode_getattr, const struct path *path)
-LSM_HOOK(int, 0, inode_setxattr, struct mnt_idmap *idmap,
-	 struct dentry *dentry, const char *name, const void *value,
-	 size_t size, int flags)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), inode_rename, struct inode *old_dir,
+	 struct dentry *old_dentry, struct inode *new_dir, struct dentry *new_dentry)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), inode_readlink, struct dentry *dentry)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), inode_follow_link, struct dentry *dentry,
+	 struct inode *inode, bool rcu)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), inode_permission, struct inode *inode, int mask)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), inode_setattr, struct mnt_idmap *idmap,
+	 struct dentry *dentry, struct iattr *attr)
+LSM_HOOK(void, LSM_RET_VOID, inode_post_setattr, struct mnt_idmap *idmap, struct dentry *dentry,
+	 int ia_valid)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), inode_getattr, const struct path *path)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), inode_setxattr, struct mnt_idmap *idmap,
+	 struct dentry *dentry, const char *name, const void *value, size_t size, int flags)
 LSM_HOOK(void, LSM_RET_VOID, inode_post_setxattr, struct dentry *dentry,
 	 const char *name, const void *value, size_t size, int flags)
-LSM_HOOK(int, 0, inode_getxattr, struct dentry *dentry, const char *name)
-LSM_HOOK(int, 0, inode_listxattr, struct dentry *dentry)
-LSM_HOOK(int, 0, inode_removexattr, struct mnt_idmap *idmap,
-	 struct dentry *dentry, const char *name)
-LSM_HOOK(void, LSM_RET_VOID, inode_post_removexattr, struct dentry *dentry,
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), inode_getxattr, struct dentry *dentry,
 	 const char *name)
-LSM_HOOK(int, 0, inode_set_acl, struct mnt_idmap *idmap,
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), inode_listxattr, struct dentry *dentry)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), inode_removexattr, struct mnt_idmap *idmap,
+	 struct dentry *dentry, const char *name)
+LSM_HOOK(void, LSM_RET_VOID, inode_post_removexattr, struct dentry *dentry, const char *name)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), inode_set_acl, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *acl_name, struct posix_acl *kacl)
 LSM_HOOK(void, LSM_RET_VOID, inode_post_set_acl, struct dentry *dentry,
 	 const char *acl_name, struct posix_acl *kacl)
-LSM_HOOK(int, 0, inode_get_acl, struct mnt_idmap *idmap,
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), inode_get_acl, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *acl_name)
-LSM_HOOK(int, 0, inode_remove_acl, struct mnt_idmap *idmap,
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), inode_remove_acl, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *acl_name)
 LSM_HOOK(void, LSM_RET_VOID, inode_post_remove_acl, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *acl_name)
-LSM_HOOK(int, 0, inode_need_killpriv, struct dentry *dentry)
-LSM_HOOK(int, 0, inode_killpriv, struct mnt_idmap *idmap,
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, INT_MAX), inode_need_killpriv, struct dentry *dentry)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), inode_killpriv, struct mnt_idmap *idmap,
 	 struct dentry *dentry)
-LSM_HOOK(int, -EOPNOTSUPP, inode_getsecurity, struct mnt_idmap *idmap,
-	 struct inode *inode, const char *name, void **buffer, bool alloc)
-LSM_HOOK(int, -EOPNOTSUPP, inode_setsecurity, struct inode *inode,
+LSM_HOOK(int, LSM_RET_INT(-EOPNOTSUPP, -MAX_ERRNO, INT_MAX), inode_getsecurity,
+	 struct mnt_idmap *idmap, struct inode *inode, const char *name, void **buffer, bool alloc)
+LSM_HOOK(int, LSM_RET_INT(-EOPNOTSUPP, -MAX_ERRNO, 0), inode_setsecurity, struct inode *inode,
 	 const char *name, const void *value, size_t size, int flags)
-LSM_HOOK(int, 0, inode_listsecurity, struct inode *inode, char *buffer,
-	 size_t buffer_size)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, INT_MAX), inode_listsecurity, struct inode *inode,
+	 char *buffer, size_t buffer_size)
 LSM_HOOK(void, LSM_RET_VOID, inode_getsecid, struct inode *inode, u32 *secid)
-LSM_HOOK(int, 0, inode_copy_up, struct dentry *src, struct cred **new)
-LSM_HOOK(int, -EOPNOTSUPP, inode_copy_up_xattr, const char *name)
-LSM_HOOK(int, 0, kernfs_init_security, struct kernfs_node *kn_dir,
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), inode_copy_up, struct dentry *src, struct cred **new)
+LSM_HOOK(int, LSM_RET_INT(-EOPNOTSUPP, -MAX_ERRNO, 1), inode_copy_up_xattr, const char *name)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), kernfs_init_security, struct kernfs_node *kn_dir,
 	 struct kernfs_node *kn)
-LSM_HOOK(int, 0, file_permission, struct file *file, int mask)
-LSM_HOOK(int, 0, file_alloc_security, struct file *file)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), file_permission, struct file *file, int mask)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), file_alloc_security, struct file *file)
 LSM_HOOK(void, LSM_RET_VOID, file_release, struct file *file)
 LSM_HOOK(void, LSM_RET_VOID, file_free_security, struct file *file)
-LSM_HOOK(int, 0, file_ioctl, struct file *file, unsigned int cmd,
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), file_ioctl, struct file *file, unsigned int cmd,
 	 unsigned long arg)
-LSM_HOOK(int, 0, file_ioctl_compat, struct file *file, unsigned int cmd,
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), file_ioctl_compat, struct file *file, unsigned int cmd,
 	 unsigned long arg)
-LSM_HOOK(int, 0, mmap_addr, unsigned long addr)
-LSM_HOOK(int, 0, mmap_file, struct file *file, unsigned long reqprot,
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), mmap_addr, unsigned long addr)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), mmap_file, struct file *file, unsigned long reqprot,
 	 unsigned long prot, unsigned long flags)
-LSM_HOOK(int, 0, file_mprotect, struct vm_area_struct *vma,
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), file_mprotect, struct vm_area_struct *vma,
 	 unsigned long reqprot, unsigned long prot)
-LSM_HOOK(int, 0, file_lock, struct file *file, unsigned int cmd)
-LSM_HOOK(int, 0, file_fcntl, struct file *file, unsigned int cmd,
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), file_lock, struct file *file, unsigned int cmd)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), file_fcntl, struct file *file, unsigned int cmd,
 	 unsigned long arg)
 LSM_HOOK(void, LSM_RET_VOID, file_set_fowner, struct file *file)
-LSM_HOOK(int, 0, file_send_sigiotask, struct task_struct *tsk,
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), file_send_sigiotask, struct task_struct *tsk,
 	 struct fown_struct *fown, int sig)
-LSM_HOOK(int, 0, file_receive, struct file *file)
-LSM_HOOK(int, 0, file_open, struct file *file)
-LSM_HOOK(int, 0, file_post_open, struct file *file, int mask)
-LSM_HOOK(int, 0, file_truncate, struct file *file)
-LSM_HOOK(int, 0, task_alloc, struct task_struct *task,
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), file_receive, struct file *file)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), file_open, struct file *file)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), file_post_open, struct file *file, int mask)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), file_truncate, struct file *file)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), task_alloc, struct task_struct *task,
 	 unsigned long clone_flags)
 LSM_HOOK(void, LSM_RET_VOID, task_free, struct task_struct *task)
-LSM_HOOK(int, 0, cred_alloc_blank, struct cred *cred, gfp_t gfp)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), cred_alloc_blank, struct cred *cred, gfp_t gfp)
 LSM_HOOK(void, LSM_RET_VOID, cred_free, struct cred *cred)
-LSM_HOOK(int, 0, cred_prepare, struct cred *new, const struct cred *old,
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), cred_prepare, struct cred *new, const struct cred *old,
 	 gfp_t gfp)
-LSM_HOOK(void, LSM_RET_VOID, cred_transfer, struct cred *new,
-	 const struct cred *old)
+LSM_HOOK(void, LSM_RET_VOID, cred_transfer, struct cred *new, const struct cred *old)
 LSM_HOOK(void, LSM_RET_VOID, cred_getsecid, const struct cred *c, u32 *secid)
-LSM_HOOK(int, 0, kernel_act_as, struct cred *new, u32 secid)
-LSM_HOOK(int, 0, kernel_create_files_as, struct cred *new, struct inode *inode)
-LSM_HOOK(int, 0, kernel_module_request, char *kmod_name)
-LSM_HOOK(int, 0, kernel_load_data, enum kernel_load_data_id id, bool contents)
-LSM_HOOK(int, 0, kernel_post_load_data, char *buf, loff_t size,
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), kernel_act_as, struct cred *new, u32 secid)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), kernel_create_files_as, struct cred *new,
+	 struct inode *inode)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), kernel_module_request, char *kmod_name)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), kernel_load_data, enum kernel_load_data_id id,
+	 bool contents)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), kernel_post_load_data, char *buf, loff_t size,
 	 enum kernel_load_data_id id, char *description)
-LSM_HOOK(int, 0, kernel_read_file, struct file *file,
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), kernel_read_file, struct file *file,
 	 enum kernel_read_file_id id, bool contents)
-LSM_HOOK(int, 0, kernel_post_read_file, struct file *file, char *buf,
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), kernel_post_read_file, struct file *file, char *buf,
 	 loff_t size, enum kernel_read_file_id id)
-LSM_HOOK(int, 0, task_fix_setuid, struct cred *new, const struct cred *old,
-	 int flags)
-LSM_HOOK(int, 0, task_fix_setgid, struct cred *new, const struct cred * old,
-	 int flags)
-LSM_HOOK(int, 0, task_fix_setgroups, struct cred *new, const struct cred * old)
-LSM_HOOK(int, 0, task_setpgid, struct task_struct *p, pid_t pgid)
-LSM_HOOK(int, 0, task_getpgid, struct task_struct *p)
-LSM_HOOK(int, 0, task_getsid, struct task_struct *p)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), task_fix_setuid, struct cred *new,
+	 const struct cred *old, int flags)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), task_fix_setgid, struct cred *new,
+	 const struct cred *old, int flags)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), task_fix_setgroups, struct cred *new,
+	 const struct cred *old)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), task_setpgid, struct task_struct *p, pid_t pgid)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), task_getpgid, struct task_struct *p)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), task_getsid, struct task_struct *p)
 LSM_HOOK(void, LSM_RET_VOID, current_getsecid_subj, u32 *secid)
-LSM_HOOK(void, LSM_RET_VOID, task_getsecid_obj,
-	 struct task_struct *p, u32 *secid)
-LSM_HOOK(int, 0, task_setnice, struct task_struct *p, int nice)
-LSM_HOOK(int, 0, task_setioprio, struct task_struct *p, int ioprio)
-LSM_HOOK(int, 0, task_getioprio, struct task_struct *p)
-LSM_HOOK(int, 0, task_prlimit, const struct cred *cred,
+LSM_HOOK(void, LSM_RET_VOID, task_getsecid_obj, struct task_struct *p, u32 *secid)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), task_setnice, struct task_struct *p, int nice)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), task_setioprio, struct task_struct *p, int ioprio)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), task_getioprio, struct task_struct *p)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), task_prlimit, const struct cred *cred,
 	 const struct cred *tcred, unsigned int flags)
-LSM_HOOK(int, 0, task_setrlimit, struct task_struct *p, unsigned int resource,
-	 struct rlimit *new_rlim)
-LSM_HOOK(int, 0, task_setscheduler, struct task_struct *p)
-LSM_HOOK(int, 0, task_getscheduler, struct task_struct *p)
-LSM_HOOK(int, 0, task_movememory, struct task_struct *p)
-LSM_HOOK(int, 0, task_kill, struct task_struct *p, struct kernel_siginfo *info,
-	 int sig, const struct cred *cred)
-LSM_HOOK(int, -ENOSYS, task_prctl, int option, unsigned long arg2,
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), task_setrlimit, struct task_struct *p,
+	 unsigned int resource, struct rlimit *new_rlim)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), task_setscheduler, struct task_struct *p)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), task_getscheduler, struct task_struct *p)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), task_movememory, struct task_struct *p)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), task_kill, struct task_struct *p,
+	 struct kernel_siginfo *info, int sig, const struct cred *cred)
+LSM_HOOK(int, LSM_RET_INT(-ENOSYS, -MAX_ERRNO, INT_MAX), task_prctl, int option, unsigned long arg2,
 	 unsigned long arg3, unsigned long arg4, unsigned long arg5)
-LSM_HOOK(void, LSM_RET_VOID, task_to_inode, struct task_struct *p,
-	 struct inode *inode)
-LSM_HOOK(int, 0, userns_create, const struct cred *cred)
-LSM_HOOK(int, 0, ipc_permission, struct kern_ipc_perm *ipcp, short flag)
-LSM_HOOK(void, LSM_RET_VOID, ipc_getsecid, struct kern_ipc_perm *ipcp,
-	 u32 *secid)
-LSM_HOOK(int, 0, msg_msg_alloc_security, struct msg_msg *msg)
+LSM_HOOK(void, LSM_RET_VOID, task_to_inode, struct task_struct *p, struct inode *inode)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), userns_create, const struct cred *cred)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), ipc_permission, struct kern_ipc_perm *ipcp, short flag)
+LSM_HOOK(void, LSM_RET_VOID, ipc_getsecid, struct kern_ipc_perm *ipcp, u32 *secid)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), msg_msg_alloc_security, struct msg_msg *msg)
 LSM_HOOK(void, LSM_RET_VOID, msg_msg_free_security, struct msg_msg *msg)
-LSM_HOOK(int, 0, msg_queue_alloc_security, struct kern_ipc_perm *perm)
-LSM_HOOK(void, LSM_RET_VOID, msg_queue_free_security,
-	 struct kern_ipc_perm *perm)
-LSM_HOOK(int, 0, msg_queue_associate, struct kern_ipc_perm *perm, int msqflg)
-LSM_HOOK(int, 0, msg_queue_msgctl, struct kern_ipc_perm *perm, int cmd)
-LSM_HOOK(int, 0, msg_queue_msgsnd, struct kern_ipc_perm *perm,
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), msg_queue_alloc_security, struct kern_ipc_perm *perm)
+LSM_HOOK(void, LSM_RET_VOID, msg_queue_free_security, struct kern_ipc_perm *perm)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), msg_queue_associate, struct kern_ipc_perm *perm,
+	 int msqflg)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), msg_queue_msgctl, struct kern_ipc_perm *perm, int cmd)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), msg_queue_msgsnd, struct kern_ipc_perm *perm,
 	 struct msg_msg *msg, int msqflg)
-LSM_HOOK(int, 0, msg_queue_msgrcv, struct kern_ipc_perm *perm,
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), msg_queue_msgrcv, struct kern_ipc_perm *perm,
 	 struct msg_msg *msg, struct task_struct *target, long type, int mode)
-LSM_HOOK(int, 0, shm_alloc_security, struct kern_ipc_perm *perm)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), shm_alloc_security, struct kern_ipc_perm *perm)
 LSM_HOOK(void, LSM_RET_VOID, shm_free_security, struct kern_ipc_perm *perm)
-LSM_HOOK(int, 0, shm_associate, struct kern_ipc_perm *perm, int shmflg)
-LSM_HOOK(int, 0, shm_shmctl, struct kern_ipc_perm *perm, int cmd)
-LSM_HOOK(int, 0, shm_shmat, struct kern_ipc_perm *perm, char __user *shmaddr,
-	 int shmflg)
-LSM_HOOK(int, 0, sem_alloc_security, struct kern_ipc_perm *perm)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), shm_associate, struct kern_ipc_perm *perm, int shmflg)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), shm_shmctl, struct kern_ipc_perm *perm, int cmd)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), shm_shmat, struct kern_ipc_perm *perm,
+	 char __user *shmaddr, int shmflg)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), sem_alloc_security, struct kern_ipc_perm *perm)
 LSM_HOOK(void, LSM_RET_VOID, sem_free_security, struct kern_ipc_perm *perm)
-LSM_HOOK(int, 0, sem_associate, struct kern_ipc_perm *perm, int semflg)
-LSM_HOOK(int, 0, sem_semctl, struct kern_ipc_perm *perm, int cmd)
-LSM_HOOK(int, 0, sem_semop, struct kern_ipc_perm *perm, struct sembuf *sops,
-	 unsigned nsops, int alter)
-LSM_HOOK(int, 0, netlink_send, struct sock *sk, struct sk_buff *skb)
-LSM_HOOK(void, LSM_RET_VOID, d_instantiate, struct dentry *dentry,
-	 struct inode *inode)
-LSM_HOOK(int, -EOPNOTSUPP, getselfattr, unsigned int attr,
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), sem_associate, struct kern_ipc_perm *perm, int semflg)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), sem_semctl, struct kern_ipc_perm *perm, int cmd)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), sem_semop, struct kern_ipc_perm *perm,
+	 struct sembuf *sops, unsigned nsops, int alter)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), netlink_send, struct sock *sk, struct sk_buff *skb)
+LSM_HOOK(void, LSM_RET_VOID, d_instantiate, struct dentry *dentry, struct inode *inode)
+LSM_HOOK(int, LSM_RET_INT(-EOPNOTSUPP, -MAX_ERRNO, INT_MAX), getselfattr, unsigned int attr,
 	 struct lsm_ctx __user *ctx, u32 *size, u32 flags)
-LSM_HOOK(int, -EOPNOTSUPP, setselfattr, unsigned int attr,
+LSM_HOOK(int, LSM_RET_INT(-EOPNOTSUPP, -MAX_ERRNO, 0), setselfattr, unsigned int attr,
 	 struct lsm_ctx *ctx, u32 size, u32 flags)
-LSM_HOOK(int, -EINVAL, getprocattr, struct task_struct *p, const char *name,
-	 char **value)
-LSM_HOOK(int, -EINVAL, setprocattr, const char *name, void *value, size_t size)
-LSM_HOOK(int, 0, ismaclabel, const char *name)
-LSM_HOOK(int, -EOPNOTSUPP, secid_to_secctx, u32 secid, char **secdata,
+LSM_HOOK(int, LSM_RET_INT(-EINVAL, -MAX_ERRNO, INT_MAX), getprocattr, struct task_struct *p,
+	 const char *name, char **value)
+LSM_HOOK(int, LSM_RET_INT(-EINVAL, -MAX_ERRNO, INT_MAX), setprocattr, const char *name, void *value,
+	 size_t size)
+LSM_HOOK(int, LSM_RET_INT(0, 0, 1), ismaclabel, const char *name)
+LSM_HOOK(int, LSM_RET_INT(-EOPNOTSUPP, -MAX_ERRNO, 0), secid_to_secctx, u32 secid, char **secdata,
 	 u32 *seclen)
-LSM_HOOK(int, 0, secctx_to_secid, const char *secdata, u32 seclen, u32 *secid)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), secctx_to_secid, const char *secdata, u32 seclen,
+	 u32 *secid)
 LSM_HOOK(void, LSM_RET_VOID, release_secctx, char *secdata, u32 seclen)
 LSM_HOOK(void, LSM_RET_VOID, inode_invalidate_secctx, struct inode *inode)
-LSM_HOOK(int, 0, inode_notifysecctx, struct inode *inode, void *ctx, u32 ctxlen)
-LSM_HOOK(int, 0, inode_setsecctx, struct dentry *dentry, void *ctx, u32 ctxlen)
-LSM_HOOK(int, -EOPNOTSUPP, inode_getsecctx, struct inode *inode, void **ctx,
-	 u32 *ctxlen)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), inode_notifysecctx, struct inode *inode, void *ctx,
+	 u32 ctxlen)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), inode_setsecctx, struct dentry *dentry, void *ctx,
+	 u32 ctxlen)
+LSM_HOOK(int, LSM_RET_INT(-EOPNOTSUPP, -MAX_ERRNO, 0), inode_getsecctx, struct inode *inode,
+	 void **ctx, u32 *ctxlen)
 
 #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
-LSM_HOOK(int, 0, post_notification, const struct cred *w_cred,
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), post_notification, const struct cred *w_cred,
 	 const struct cred *cred, struct watch_notification *n)
 #endif /* CONFIG_SECURITY && CONFIG_WATCH_QUEUE */
 
 #if defined(CONFIG_SECURITY) && defined(CONFIG_KEY_NOTIFICATIONS)
-LSM_HOOK(int, 0, watch_key, struct key *key)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), watch_key, struct key *key)
 #endif /* CONFIG_SECURITY && CONFIG_KEY_NOTIFICATIONS */
 
 #ifdef CONFIG_SECURITY_NETWORK
-LSM_HOOK(int, 0, unix_stream_connect, struct sock *sock, struct sock *other,
-	 struct sock *newsk)
-LSM_HOOK(int, 0, unix_may_send, struct socket *sock, struct socket *other)
-LSM_HOOK(int, 0, socket_create, int family, int type, int protocol, int kern)
-LSM_HOOK(int, 0, socket_post_create, struct socket *sock, int family, int type,
-	 int protocol, int kern)
-LSM_HOOK(int, 0, socket_socketpair, struct socket *socka, struct socket *sockb)
-LSM_HOOK(int, 0, socket_bind, struct socket *sock, struct sockaddr *address,
-	 int addrlen)
-LSM_HOOK(int, 0, socket_connect, struct socket *sock, struct sockaddr *address,
-	 int addrlen)
-LSM_HOOK(int, 0, socket_listen, struct socket *sock, int backlog)
-LSM_HOOK(int, 0, socket_accept, struct socket *sock, struct socket *newsock)
-LSM_HOOK(int, 0, socket_sendmsg, struct socket *sock, struct msghdr *msg,
-	 int size)
-LSM_HOOK(int, 0, socket_recvmsg, struct socket *sock, struct msghdr *msg,
-	 int size, int flags)
-LSM_HOOK(int, 0, socket_getsockname, struct socket *sock)
-LSM_HOOK(int, 0, socket_getpeername, struct socket *sock)
-LSM_HOOK(int, 0, socket_getsockopt, struct socket *sock, int level, int optname)
-LSM_HOOK(int, 0, socket_setsockopt, struct socket *sock, int level, int optname)
-LSM_HOOK(int, 0, socket_shutdown, struct socket *sock, int how)
-LSM_HOOK(int, 0, socket_sock_rcv_skb, struct sock *sk, struct sk_buff *skb)
-LSM_HOOK(int, -ENOPROTOOPT, socket_getpeersec_stream, struct socket *sock,
-	 sockptr_t optval, sockptr_t optlen, unsigned int len)
-LSM_HOOK(int, -ENOPROTOOPT, socket_getpeersec_dgram, struct socket *sock,
-	 struct sk_buff *skb, u32 *secid)
-LSM_HOOK(int, 0, sk_alloc_security, struct sock *sk, int family, gfp_t priority)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), unix_stream_connect, struct sock *sock,
+	 struct sock *other, struct sock *newsk)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), unix_may_send, struct socket *sock,
+	 struct socket *other)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), socket_create, int family, int type, int protocol,
+	 int kern)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), socket_post_create, struct socket *sock, int family,
+	 int type, int protocol, int kern)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), socket_socketpair, struct socket *socka,
+	 struct socket *sockb)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), socket_bind, struct socket *sock,
+	 struct sockaddr *address, int addrlen)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), socket_connect, struct socket *sock,
+	 struct sockaddr *address, int addrlen)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), socket_listen, struct socket *sock, int backlog)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), socket_accept, struct socket *sock,
+	 struct socket *newsock)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), socket_sendmsg, struct socket *sock,
+	 struct msghdr *msg, int size)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), socket_recvmsg, struct socket *sock,
+	 struct msghdr *msg, int size, int flags)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), socket_getsockname, struct socket *sock)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), socket_getpeername, struct socket *sock)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), socket_getsockopt, struct socket *sock, int level,
+	 int optname)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), socket_setsockopt, struct socket *sock, int level,
+	 int optname)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), socket_shutdown, struct socket *sock, int how)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), socket_sock_rcv_skb, struct sock *sk,
+	 struct sk_buff *skb)
+LSM_HOOK(int, LSM_RET_INT(-ENOPROTOOPT, -MAX_ERRNO, 0), socket_getpeersec_stream,
+	 struct socket *sock, sockptr_t optval, sockptr_t optlen, unsigned int len)
+LSM_HOOK(int, LSM_RET_INT(-ENOPROTOOPT, -MAX_ERRNO, 0), socket_getpeersec_dgram,
+	 struct socket *sock, struct sk_buff *skb, u32 *secid)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), sk_alloc_security, struct sock *sk, int family,
+	 gfp_t priority)
 LSM_HOOK(void, LSM_RET_VOID, sk_free_security, struct sock *sk)
-LSM_HOOK(void, LSM_RET_VOID, sk_clone_security, const struct sock *sk,
-	 struct sock *newsk)
+LSM_HOOK(void, LSM_RET_VOID, sk_clone_security, const struct sock *sk, struct sock *newsk)
 LSM_HOOK(void, LSM_RET_VOID, sk_getsecid, const struct sock *sk, u32 *secid)
 LSM_HOOK(void, LSM_RET_VOID, sock_graft, struct sock *sk, struct socket *parent)
-LSM_HOOK(int, 0, inet_conn_request, const struct sock *sk, struct sk_buff *skb,
-	 struct request_sock *req)
-LSM_HOOK(void, LSM_RET_VOID, inet_csk_clone, struct sock *newsk,
-	 const struct request_sock *req)
-LSM_HOOK(void, LSM_RET_VOID, inet_conn_established, struct sock *sk,
-	 struct sk_buff *skb)
-LSM_HOOK(int, 0, secmark_relabel_packet, u32 secid)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), inet_conn_request, const struct sock *sk,
+	 struct sk_buff *skb, struct request_sock *req)
+LSM_HOOK(void, LSM_RET_VOID, inet_csk_clone, struct sock *newsk, const struct request_sock *req)
+LSM_HOOK(void, LSM_RET_VOID, inet_conn_established, struct sock *sk, struct sk_buff *skb)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), secmark_relabel_packet, u32 secid)
 LSM_HOOK(void, LSM_RET_VOID, secmark_refcount_inc, void)
 LSM_HOOK(void, LSM_RET_VOID, secmark_refcount_dec, void)
 LSM_HOOK(void, LSM_RET_VOID, req_classify_flow, const struct request_sock *req,
 	 struct flowi_common *flic)
-LSM_HOOK(int, 0, tun_dev_alloc_security, void **security)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), tun_dev_alloc_security, void **security)
 LSM_HOOK(void, LSM_RET_VOID, tun_dev_free_security, void *security)
-LSM_HOOK(int, 0, tun_dev_create, void)
-LSM_HOOK(int, 0, tun_dev_attach_queue, void *security)
-LSM_HOOK(int, 0, tun_dev_attach, struct sock *sk, void *security)
-LSM_HOOK(int, 0, tun_dev_open, void *security)
-LSM_HOOK(int, 0, sctp_assoc_request, struct sctp_association *asoc,
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), tun_dev_create, void)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), tun_dev_attach_queue, void *security)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), tun_dev_attach, struct sock *sk, void *security)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), tun_dev_open, void *security)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), sctp_assoc_request, struct sctp_association *asoc,
 	 struct sk_buff *skb)
-LSM_HOOK(int, 0, sctp_bind_connect, struct sock *sk, int optname,
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), sctp_bind_connect, struct sock *sk, int optname,
 	 struct sockaddr *address, int addrlen)
 LSM_HOOK(void, LSM_RET_VOID, sctp_sk_clone, struct sctp_association *asoc,
 	 struct sock *sk, struct sock *newsk)
-LSM_HOOK(int, 0, sctp_assoc_established, struct sctp_association *asoc,
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), sctp_assoc_established, struct sctp_association *asoc,
 	 struct sk_buff *skb)
-LSM_HOOK(int, 0, mptcp_add_subflow, struct sock *sk, struct sock *ssk)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), mptcp_add_subflow, struct sock *sk, struct sock *ssk)
 #endif /* CONFIG_SECURITY_NETWORK */
 
 #ifdef CONFIG_SECURITY_INFINIBAND
-LSM_HOOK(int, 0, ib_pkey_access, void *sec, u64 subnet_prefix, u16 pkey)
-LSM_HOOK(int, 0, ib_endport_manage_subnet, void *sec, const char *dev_name,
-	 u8 port_num)
-LSM_HOOK(int, 0, ib_alloc_security, void **sec)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), ib_pkey_access, void *sec, u64 subnet_prefix, u16 pkey)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), ib_endport_manage_subnet, void *sec,
+	 const char *dev_name, u8 port_num)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), ib_alloc_security, void **sec)
 LSM_HOOK(void, LSM_RET_VOID, ib_free_security, void *sec)
 #endif /* CONFIG_SECURITY_INFINIBAND */
 
 #ifdef CONFIG_SECURITY_NETWORK_XFRM
-LSM_HOOK(int, 0, xfrm_policy_alloc_security, struct xfrm_sec_ctx **ctxp,
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), xfrm_policy_alloc_security, struct xfrm_sec_ctx **ctxp,
 	 struct xfrm_user_sec_ctx *sec_ctx, gfp_t gfp)
-LSM_HOOK(int, 0, xfrm_policy_clone_security, struct xfrm_sec_ctx *old_ctx,
-	 struct xfrm_sec_ctx **new_ctx)
-LSM_HOOK(void, LSM_RET_VOID, xfrm_policy_free_security,
-	 struct xfrm_sec_ctx *ctx)
-LSM_HOOK(int, 0, xfrm_policy_delete_security, struct xfrm_sec_ctx *ctx)
-LSM_HOOK(int, 0, xfrm_state_alloc, struct xfrm_state *x,
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), xfrm_policy_clone_security,
+	 struct xfrm_sec_ctx *old_ctx, struct xfrm_sec_ctx **new_ctx)
+LSM_HOOK(void, LSM_RET_VOID, xfrm_policy_free_security, struct xfrm_sec_ctx *ctx)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), xfrm_policy_delete_security, struct xfrm_sec_ctx *ctx)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), xfrm_state_alloc, struct xfrm_state *x,
 	 struct xfrm_user_sec_ctx *sec_ctx)
-LSM_HOOK(int, 0, xfrm_state_alloc_acquire, struct xfrm_state *x,
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), xfrm_state_alloc_acquire, struct xfrm_state *x,
 	 struct xfrm_sec_ctx *polsec, u32 secid)
 LSM_HOOK(void, LSM_RET_VOID, xfrm_state_free_security, struct xfrm_state *x)
-LSM_HOOK(int, 0, xfrm_state_delete_security, struct xfrm_state *x)
-LSM_HOOK(int, 0, xfrm_policy_lookup, struct xfrm_sec_ctx *ctx, u32 fl_secid)
-LSM_HOOK(int, 1, xfrm_state_pol_flow_match, struct xfrm_state *x,
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), xfrm_state_delete_security, struct xfrm_state *x)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), xfrm_policy_lookup, struct xfrm_sec_ctx *ctx,
+	 u32 fl_secid)
+LSM_HOOK(int, LSM_RET_INT(1, INT_MIN, INT_MAX), xfrm_state_pol_flow_match, struct xfrm_state *x,
 	 struct xfrm_policy *xp, const struct flowi_common *flic)
-LSM_HOOK(int, 0, xfrm_decode_session, struct sk_buff *skb, u32 *secid,
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), xfrm_decode_session, struct sk_buff *skb, u32 *secid,
 	 int ckall)
 #endif /* CONFIG_SECURITY_NETWORK_XFRM */
 
 /* key management security hooks */
 #ifdef CONFIG_KEYS
-LSM_HOOK(int, 0, key_alloc, struct key *key, const struct cred *cred,
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), key_alloc, struct key *key, const struct cred *cred,
 	 unsigned long flags)
 LSM_HOOK(void, LSM_RET_VOID, key_free, struct key *key)
-LSM_HOOK(int, 0, key_permission, key_ref_t key_ref, const struct cred *cred,
-	 enum key_need_perm need_perm)
-LSM_HOOK(int, 0, key_getsecurity, struct key *key, char **buffer)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), key_permission, key_ref_t key_ref,
+	 const struct cred *cred, enum key_need_perm need_perm)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, INT_MAX), key_getsecurity, struct key *key, char **buffer)
 LSM_HOOK(void, LSM_RET_VOID, key_post_create_or_update, struct key *keyring,
-	 struct key *key, const void *payload, size_t payload_len,
-	 unsigned long flags, bool create)
+	 struct key *key, const void *payload, size_t payload_len, unsigned long flags, bool create)
 #endif /* CONFIG_KEYS */
 
 #ifdef CONFIG_AUDIT
-LSM_HOOK(int, 0, audit_rule_init, u32 field, u32 op, char *rulestr,
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), audit_rule_init, u32 field, u32 op, char *rulestr,
 	 void **lsmrule)
-LSM_HOOK(int, 0, audit_rule_known, struct audit_krule *krule)
-LSM_HOOK(int, 0, audit_rule_match, u32 secid, u32 field, u32 op, void *lsmrule)
+LSM_HOOK(int, LSM_RET_INT(0, 0, 1), audit_rule_known, struct audit_krule *krule)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 1), audit_rule_match, u32 secid, u32 field, u32 op,
+	 void *lsmrule)
 LSM_HOOK(void, LSM_RET_VOID, audit_rule_free, void *lsmrule)
 #endif /* CONFIG_AUDIT */
 
 #ifdef CONFIG_BPF_SYSCALL
-LSM_HOOK(int, 0, bpf, int cmd, union bpf_attr *attr, unsigned int size)
-LSM_HOOK(int, 0, bpf_map, struct bpf_map *map, fmode_t fmode)
-LSM_HOOK(int, 0, bpf_prog, struct bpf_prog *prog)
-LSM_HOOK(int, 0, bpf_map_create, struct bpf_map *map, union bpf_attr *attr,
-	 struct bpf_token *token)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), bpf, int cmd, union bpf_attr *attr, unsigned int size)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), bpf_map, struct bpf_map *map, fmode_t fmode)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), bpf_prog, struct bpf_prog *prog)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), bpf_map_create, struct bpf_map *map,
+	 union bpf_attr *attr, struct bpf_token *token)
 LSM_HOOK(void, LSM_RET_VOID, bpf_map_free, struct bpf_map *map)
-LSM_HOOK(int, 0, bpf_prog_load, struct bpf_prog *prog, union bpf_attr *attr,
-	 struct bpf_token *token)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), bpf_prog_load, struct bpf_prog *prog,
+	 union bpf_attr *attr, struct bpf_token *token)
 LSM_HOOK(void, LSM_RET_VOID, bpf_prog_free, struct bpf_prog *prog)
-LSM_HOOK(int, 0, bpf_token_create, struct bpf_token *token, union bpf_attr *attr,
-	 struct path *path)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), bpf_token_create, struct bpf_token *token,
+	 union bpf_attr *attr, struct path *path)
 LSM_HOOK(void, LSM_RET_VOID, bpf_token_free, struct bpf_token *token)
-LSM_HOOK(int, 0, bpf_token_cmd, const struct bpf_token *token, enum bpf_cmd cmd)
-LSM_HOOK(int, 0, bpf_token_capable, const struct bpf_token *token, int cap)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), bpf_token_cmd, const struct bpf_token *token,
+	 enum bpf_cmd cmd)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), bpf_token_capable, const struct bpf_token *token,
+	 int cap)
 #endif /* CONFIG_BPF_SYSCALL */
 
-LSM_HOOK(int, 0, locked_down, enum lockdown_reason what)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), locked_down, enum lockdown_reason what)
 
 #ifdef CONFIG_PERF_EVENTS
-LSM_HOOK(int, 0, perf_event_open, struct perf_event_attr *attr, int type)
-LSM_HOOK(int, 0, perf_event_alloc, struct perf_event *event)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), perf_event_open, struct perf_event_attr *attr,
+	 int type)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), perf_event_alloc, struct perf_event *event)
 LSM_HOOK(void, LSM_RET_VOID, perf_event_free, struct perf_event *event)
-LSM_HOOK(int, 0, perf_event_read, struct perf_event *event)
-LSM_HOOK(int, 0, perf_event_write, struct perf_event *event)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), perf_event_read, struct perf_event *event)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), perf_event_write, struct perf_event *event)
 #endif /* CONFIG_PERF_EVENTS */
 
 #ifdef CONFIG_IO_URING
-LSM_HOOK(int, 0, uring_override_creds, const struct cred *new)
-LSM_HOOK(int, 0, uring_sqpoll, void)
-LSM_HOOK(int, 0, uring_cmd, struct io_uring_cmd *ioucmd)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), uring_override_creds, const struct cred *new)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), uring_sqpoll, void)
+LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), uring_cmd, struct io_uring_cmd *ioucmd)
 #endif /* CONFIG_IO_URING */
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index a2ade0ffe9e7..14690cad4fb9 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -98,12 +98,6 @@ static inline struct xattr *lsm_get_xattr_slot(struct xattr *xattrs,
 	return &xattrs[(*xattr_count)++];
 }
 
-/*
- * LSM_RET_VOID is used as the default value in LSM_HOOK definitions for void
- * LSM hooks (in include/linux/lsm_hook_defs.h).
- */
-#define LSM_RET_VOID ((void) 0)
-
 /*
  * Initializing a security_hook_list structure takes
  * up a lot of space in a source file. This macro takes
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 68240c3c6e7d..ee9d1a795334 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -18,6 +18,14 @@
 #include <linux/ima.h>
 #include <linux/bpf-cgroup.h>
 
+/*
+ * LSM_RET_VOID is used as the default value in LSM_HOOK definitions for void
+ * LSM hooks (in include/linux/lsm_hook_defs.h).
+ */
+#define LSM_RET_VOID ((void) 0)
+
+#define LSM_RET_INT(defval, ...) defval
+
 /* For every LSM hook that allows attachment of BPF programs, declare a nop
  * function where a BPF program can be attached.
  */
@@ -29,6 +37,8 @@ noinline RET bpf_lsm_##NAME(__VA_ARGS__)	\
 
 #include <linux/lsm_hook_defs.h>
 #undef LSM_HOOK
+#undef LSM_RET_INT
+#undef LSM_RET_VOID
 
 #define LSM_HOOK(RET, DEFAULT, NAME, ...) BTF_ID(func, bpf_lsm_##NAME)
 BTF_SET_START(bpf_lsm_hooks)
diff --git a/security/security.c b/security/security.c
index 7e118858b545..665c531497c4 100644
--- a/security/security.c
+++ b/security/security.c
@@ -834,6 +834,7 @@ int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, u32 *uctx_len,
  * The macros below define static constants for the default value of each
  * LSM hook.
  */
+#define LSM_RET_INT(defval, ...) defval
 #define LSM_RET_DEFAULT(NAME) (NAME##_default)
 #define DECLARE_LSM_RET_DEFAULT_void(DEFAULT, NAME)
 #define DECLARE_LSM_RET_DEFAULT_int(DEFAULT, NAME) \
-- 
2.30.2


