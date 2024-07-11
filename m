Return-Path: <linux-kselftest+bounces-13570-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE75692E640
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 13:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42C641F20F2F
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 11:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED66E16CD2B;
	Thu, 11 Jul 2024 11:14:10 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAC116CD15;
	Thu, 11 Jul 2024 11:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720696450; cv=none; b=QEvRsAQpY2A8wcvvBRdckmDjGpE69bLx/NJ81Oih4UltDYukU/giO5UcGojiylWKfyiuW1WuHDPXMToLI6fAn9cDfG5Tw1RkPh0FcJcooOSWb5hLupiUm37DL8z9ISwCXinJ3byTS/ATVbM7fFxf6W16IWnij6ggczluO8UGwiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720696450; c=relaxed/simple;
	bh=N0sDjFXEOLrl+eei12YY3cVHVQCyQtATfXFXgVl4uRU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W24wm/Aw7d5j9hhImTBRvy/b+7K/7y8OuyjR41iwtzpuy8IAdxW19uYScDeQYYyGQqv0StkrLJxGI5y5kH99BeSJnharq6OeQvVOmMto9H8UqvofafKGgCXEi6LHxzxJMH6hXRZhUmtnPg2/XkKrlBpw1spK+J/I0tzfd5ad1Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WKXCt4Svgz4f3kFQ;
	Thu, 11 Jul 2024 19:13:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4A1A51A0170;
	Thu, 11 Jul 2024 19:13:58 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP4 (Coremail) with SMTP id gCh0CgCHjPVxvo9mulQgBw--.25300S12;
	Thu, 11 Jul 2024 19:13:57 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	selinux@vger.kernel.org
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
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH bpf-next v4 10/20] lsm: Refactor return value of LSM hook audit_rule_match
Date: Thu, 11 Jul 2024 19:18:58 +0800
Message-Id: <20240711111908.3817636-11-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240711111908.3817636-1-xukuohai@huaweicloud.com>
References: <20240711111908.3817636-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHjPVxvo9mulQgBw--.25300S12
X-Coremail-Antispam: 1UD129KBjvJXoW3Aw4UuF4xKr13Jw1xWw1rZwb_yoWDCw4kpF
	1qvF4fArWkGF4xXrn7Ca42gr4Yvry3Cw1DCrZ8Cr1jkF9xJr1kGr48ZF4UGF95Wr45Awsa
	vanrurZayr4DXrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Wrv_Gr1UMIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAI
	cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUFgAwUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

To be consistent with most LSM hooks, convert the return value of
hook audit_rule_match to 0 or a negative error code.

Before:
- Hook audit_rule_match returns 1 if the rule matches, 0 if it not,
  and negative error code otherwise.

After:
- Hook audit_rule_match returns 0 on success or a negative error
  code on failure. An output parameter @match is introduced to hold
  the match result on success.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 include/linux/lsm_hook_defs.h     |  3 +-
 security/apparmor/audit.c         | 22 ++++++-------
 security/apparmor/include/audit.h |  2 +-
 security/security.c               | 15 ++++++++-
 security/selinux/include/audit.h  |  8 +++--
 security/selinux/ss/services.c    | 54 +++++++++++++++++--------------
 security/smack/smack_lsm.c        | 19 +++++++----
 7 files changed, 75 insertions(+), 48 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 54fec360947c..6b521744a23b 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -418,7 +418,8 @@ LSM_HOOK(void, LSM_RET_VOID, key_post_create_or_update, struct key *keyring,
 LSM_HOOK(int, 0, audit_rule_init, u32 field, u32 op, char *rulestr,
 	 void **lsmrule, gfp_t gfp)
 LSM_HOOK(int, 0, audit_rule_known, struct audit_krule *krule)
-LSM_HOOK(int, 0, audit_rule_match, u32 secid, u32 field, u32 op, void *lsmrule)
+LSM_HOOK(int, 0, audit_rule_match, u32 secid, u32 field, u32 op, void *lsmrule,
+	 bool *match)
 LSM_HOOK(void, LSM_RET_VOID, audit_rule_free, void *lsmrule)
 #endif /* CONFIG_AUDIT */
 
diff --git a/security/apparmor/audit.c b/security/apparmor/audit.c
index 6b5181c668b5..352a183b3325 100644
--- a/security/apparmor/audit.c
+++ b/security/apparmor/audit.c
@@ -264,11 +264,11 @@ int aa_audit_rule_known(struct audit_krule *rule)
 	return 0;
 }
 
-int aa_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule)
+int aa_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule, bool *match)
 {
 	struct aa_audit_rule *rule = vrule;
 	struct aa_label *label;
-	int found = 0;
+	bool found = false;
 
 	label = aa_secid_to_label(sid);
 
@@ -276,16 +276,14 @@ int aa_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule)
 		return -ENOENT;
 
 	if (aa_label_is_subset(label, rule->label))
-		found = 1;
+		found = true;
+
+	if (field == AUDIT_SUBJ_ROLE && op == Audit_equal)
+		*match = found;
+	else if (field == AUDIT_SUBJ_ROLE && op == Audit_not_equal)
+		*match = !found;
+	else
+		*match = false;
 
-	switch (field) {
-	case AUDIT_SUBJ_ROLE:
-		switch (op) {
-		case Audit_equal:
-			return found;
-		case Audit_not_equal:
-			return !found;
-		}
-	}
 	return 0;
 }
diff --git a/security/apparmor/include/audit.h b/security/apparmor/include/audit.h
index 0c8cc86b417b..a227741f33c8 100644
--- a/security/apparmor/include/audit.h
+++ b/security/apparmor/include/audit.h
@@ -202,6 +202,6 @@ static inline int complain_error(int error)
 void aa_audit_rule_free(void *vrule);
 int aa_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule, gfp_t gfp);
 int aa_audit_rule_known(struct audit_krule *rule);
-int aa_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule);
+int aa_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule, bool *match);
 
 #endif /* __AA_AUDIT_H */
diff --git a/security/security.c b/security/security.c
index 2c161101074d..5e9de8d0cdde 100644
--- a/security/security.c
+++ b/security/security.c
@@ -5450,7 +5450,20 @@ void security_audit_rule_free(void *lsmrule)
  */
 int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
 {
-	return call_int_hook(audit_rule_match, secid, field, op, lsmrule);
+	int rc;
+	bool match = false;
+	struct security_hook_list *hp;
+
+	hlist_for_each_entry(hp, &security_hook_heads.audit_rule_match, list) {
+		rc = hp->hook.audit_rule_match(secid, field, op, lsmrule,
+					       &match);
+		if (rc < 0)
+			return rc;
+		if (match)
+			break;
+	}
+
+	return match;
 }
 #endif /* CONFIG_AUDIT */
 
diff --git a/security/selinux/include/audit.h b/security/selinux/include/audit.h
index 29c7d4c86f6d..2d0799270426 100644
--- a/security/selinux/include/audit.h
+++ b/security/selinux/include/audit.h
@@ -45,11 +45,13 @@ void selinux_audit_rule_free(void *rule);
  *	@field: the field this rule refers to
  *	@op: the operator the rule uses
  *	@rule: pointer to the audit rule to check against
+ *	@match: if the context id matches the rule
  *
- *	Returns 1 if the context id matches the rule, 0 if it does not, and
- *	-errno on failure.
+ *	Returns 0 on success and -errno on failure. @match holds the match
+ *	result.
  */
-int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *rule);
+int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *rule,
+			     bool *match);
 
 /**
  *	selinux_audit_rule_known - check to see if rule contains selinux fields.
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index e33e55384b75..2946d28a25b1 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3633,29 +3633,32 @@ int selinux_audit_rule_known(struct audit_krule *rule)
 	return 0;
 }
 
-int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule)
+int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule,
+			     bool *match)
 {
 	struct selinux_state *state = &selinux_state;
 	struct selinux_policy *policy;
 	struct context *ctxt;
 	struct mls_level *level;
 	struct selinux_audit_rule *rule = vrule;
-	int match = 0;
+	int rc = 0;
 
 	if (unlikely(!rule)) {
 		WARN_ONCE(1, "selinux_audit_rule_match: missing rule\n");
 		return -ENOENT;
 	}
 
-	if (!selinux_initialized())
+	if (!selinux_initialized()) {
+		*match = false;
 		return 0;
+	}
 
 	rcu_read_lock();
 
 	policy = rcu_dereference(state->policy);
 
 	if (rule->au_seqno < policy->latest_granting) {
-		match = -ESTALE;
+		rc = -ESTALE;
 		goto out;
 	}
 
@@ -3663,7 +3666,7 @@ int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule)
 	if (unlikely(!ctxt)) {
 		WARN_ONCE(1, "selinux_audit_rule_match: unrecognized SID %d\n",
 			  sid);
-		match = -ENOENT;
+		rc = -ENOENT;
 		goto out;
 	}
 
@@ -3674,10 +3677,10 @@ int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule)
 	case AUDIT_OBJ_USER:
 		switch (op) {
 		case Audit_equal:
-			match = (ctxt->user == rule->au_ctxt.user);
+			rc = (ctxt->user == rule->au_ctxt.user);
 			break;
 		case Audit_not_equal:
-			match = (ctxt->user != rule->au_ctxt.user);
+			rc = (ctxt->user != rule->au_ctxt.user);
 			break;
 		}
 		break;
@@ -3685,10 +3688,10 @@ int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule)
 	case AUDIT_OBJ_ROLE:
 		switch (op) {
 		case Audit_equal:
-			match = (ctxt->role == rule->au_ctxt.role);
+			rc = (ctxt->role == rule->au_ctxt.role);
 			break;
 		case Audit_not_equal:
-			match = (ctxt->role != rule->au_ctxt.role);
+			rc = (ctxt->role != rule->au_ctxt.role);
 			break;
 		}
 		break;
@@ -3696,10 +3699,10 @@ int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule)
 	case AUDIT_OBJ_TYPE:
 		switch (op) {
 		case Audit_equal:
-			match = (ctxt->type == rule->au_ctxt.type);
+			rc = (ctxt->type == rule->au_ctxt.type);
 			break;
 		case Audit_not_equal:
-			match = (ctxt->type != rule->au_ctxt.type);
+			rc = (ctxt->type != rule->au_ctxt.type);
 			break;
 		}
 		break;
@@ -3712,39 +3715,42 @@ int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule)
 			 &ctxt->range.level[0] : &ctxt->range.level[1]);
 		switch (op) {
 		case Audit_equal:
-			match = mls_level_eq(&rule->au_ctxt.range.level[0],
-					     level);
+			rc = mls_level_eq(&rule->au_ctxt.range.level[0],
+					  level);
 			break;
 		case Audit_not_equal:
-			match = !mls_level_eq(&rule->au_ctxt.range.level[0],
-					      level);
+			rc = !mls_level_eq(&rule->au_ctxt.range.level[0],
+					   level);
 			break;
 		case Audit_lt:
-			match = (mls_level_dom(&rule->au_ctxt.range.level[0],
-					       level) &&
+			rc = (mls_level_dom(&rule->au_ctxt.range.level[0],
+					    level) &&
 				 !mls_level_eq(&rule->au_ctxt.range.level[0],
 					       level));
 			break;
 		case Audit_le:
-			match = mls_level_dom(&rule->au_ctxt.range.level[0],
-					      level);
+			rc = mls_level_dom(&rule->au_ctxt.range.level[0],
+					   level);
 			break;
 		case Audit_gt:
-			match = (mls_level_dom(level,
-					      &rule->au_ctxt.range.level[0]) &&
+			rc = (mls_level_dom(level,
+					    &rule->au_ctxt.range.level[0]) &&
 				 !mls_level_eq(level,
 					       &rule->au_ctxt.range.level[0]));
 			break;
 		case Audit_ge:
-			match = mls_level_dom(level,
-					      &rule->au_ctxt.range.level[0]);
+			rc = mls_level_dom(level,
+					   &rule->au_ctxt.range.level[0]);
 			break;
 		}
 	}
 
 out:
 	rcu_read_unlock();
-	return match;
+	if (rc < 0)
+		return rc;
+	*match = !!rc;
+	return 0;
 }
 
 static int aurule_avc_callback(u32 event)
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 9a121ad53b16..ea0f0cf11ff3 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4764,11 +4764,15 @@ static int smack_audit_rule_known(struct audit_krule *krule)
  * @field: audit rule flags given from user-space
  * @op: required testing operator
  * @vrule: smack internal rule presentation
+ * @match: the match result
  *
  * The core Audit hook. It's used to take the decision of
  * whether to audit or not to audit a given object.
+ *
+ * Returns 0 on success or negative error code on failure.
  */
-static int smack_audit_rule_match(u32 secid, u32 field, u32 op, void *vrule)
+static int smack_audit_rule_match(u32 secid, u32 field, u32 op, void *vrule,
+				  bool *match)
 {
 	struct smack_known *skp;
 	char *rule = vrule;
@@ -4778,8 +4782,10 @@ static int smack_audit_rule_match(u32 secid, u32 field, u32 op, void *vrule)
 		return -ENOENT;
 	}
 
-	if (field != AUDIT_SUBJ_USER && field != AUDIT_OBJ_USER)
+	if (field != AUDIT_SUBJ_USER && field != AUDIT_OBJ_USER) {
+		*match = false;
 		return 0;
+	}
 
 	skp = smack_from_secid(secid);
 
@@ -4789,10 +4795,11 @@ static int smack_audit_rule_match(u32 secid, u32 field, u32 op, void *vrule)
 	 * label.
 	 */
 	if (op == Audit_equal)
-		return (rule == skp->smk_known);
-	if (op == Audit_not_equal)
-		return (rule != skp->smk_known);
-
+		*match = (rule == skp->smk_known);
+	else if (op == Audit_not_equal)
+		*match = (rule != skp->smk_known);
+	else
+		*match = false;
 	return 0;
 }
 
-- 
2.30.2


